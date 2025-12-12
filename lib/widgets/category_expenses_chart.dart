import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../store/expense_store.dart';
import '../../store/category_store.dart';

class CategoryExpensesChart extends StatelessWidget {
  final CategoryStore categoryStore;
  final ExpenseStore expenseStore;

  const CategoryExpensesChart({
    Key? key,
    required this.categoryStore,
    required this.expenseStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryExpenses = <String, double>{};

    for (final expense in expenseStore.expenses) {
      final category = categoryStore.getCategoryById(expense.categoryId);
      if (category != null) {
        categoryExpenses.update(
          category.name,
              (value) => value + expense.amount,
          ifAbsent: () => expense.amount,
        );
      }
    }

    if (categoryExpenses.isEmpty) {
      return Container(
        height: 200,
        alignment: Alignment.center,
        child: const Text(
          'Нет данных о расходах',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    final List<PieChartSectionData> pieChartSections = [];
    int index = 0;

    categoryExpenses.forEach((categoryName, amount) {
      final category = categoryStore.categories.firstWhere(
            (c) => c.name == categoryName,
        orElse: () => categoryStore.categories.first,
      );

      final color = category.color;

      pieChartSections.add(
        PieChartSectionData(
          color: color,
          value: amount,
          title: '${amount.toStringAsFixed(0)}₽',
          radius: 80,
          titleStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titlePositionPercentageOffset: 0.6,
        ),
      );
      index++;
    });

    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      child: PieChart(
        PieChartData(
          sections: pieChartSections,
          borderData: FlBorderData(show: false),
          sectionsSpace: 2,
          centerSpaceRadius: 60,
          startDegreeOffset: -90,
        ),
      ),
    );
  }
}