import 'package:flutter/material.dart';
import '../../store/income_store.dart';
import '../../store/expense_store.dart';
import '../../store/category_store.dart';
import 'stat_card.dart';

class StatisticsDetails extends StatelessWidget {
  final CategoryStore categoryStore;
  final IncomeStore incomeStore;
  final ExpenseStore expenseStore;

  const StatisticsDetails({
    Key? key,
    required this.categoryStore,
    required this.incomeStore,
    required this.expenseStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalIncome = incomeStore.incomes.fold(0.0, (sum, item) => sum + item.amount);
    final totalExpense = expenseStore.expenses.fold(0.0, (sum, item) => sum + item.amount);
    final balance = totalIncome - totalExpense;

    final largestExpenses = expenseStore.expenses.toList()
      ..sort((a, b) => b.amount.compareTo(a.amount));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Общая статистика',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // Карточки с общей статистикой
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Доходы',
                value: totalIncome.toStringAsFixed(2),
                color: Colors.green,
                icon: Icons.arrow_upward,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: StatCard(
                title: 'Расходы',
                value: totalExpense.toStringAsFixed(2),
                color: Colors.red,
                icon: Icons.arrow_downward,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Баланс
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: balance >= 0 ? Colors.green[50] : Colors.red[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              Icon(
                balance >= 0 ? Icons.trending_up : Icons.trending_down,
                color: balance >= 0 ? Colors.green : Colors.red,
                size: 30,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Баланс'),
                    Text(
                      '${balance.toStringAsFixed(2)} ₽',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: balance >= 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Крупнейшие расходы
        if (largestExpenses.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Самые крупные расходы',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...largestExpenses.take(3).map((expense) {
                final category = categoryStore.getCategoryById(expense.categoryId);
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: category?.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        category?.icon ?? Icons.shopping_cart,
                        color: category?.color ?? Colors.red,
                      ),
                    ),
                    title: Text(expense.title),
                    subtitle: Text(category?.name ?? 'Без категории'),
                    trailing: Text(
                      '-${expense.amount.toStringAsFixed(2)} ₽',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
      ],
    );
  }
}