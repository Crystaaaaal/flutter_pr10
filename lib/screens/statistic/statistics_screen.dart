import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '/widgets/period_selector.dart';
import '/widgets/category_expenses_chart.dart';
import '/widgets/statistics_details.dart';
import '../../store/income_store.dart';
import '../../store/expense_store.dart';
import '../../store/category_store.dart';
import '/di/service_locator.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _selectedPeriod = 0;

  @override
  Widget build(BuildContext context) {
    final incomeStore = getIt<IncomeStore>();
    final expenseStore = getIt<ExpenseStore>();
    final categoryStore = getIt<CategoryStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            PeriodSelector(
              selectedPeriod: _selectedPeriod,
              onPeriodChanged: (index) {
                setState(() {
                  _selectedPeriod = index;
                });
              },
            ),
            const SizedBox(height: 20),

            Observer(
              builder: (_) => CategoryExpensesChart(
                categoryStore: categoryStore,
                expenseStore: expenseStore,
              ),
            ),

            const SizedBox(height: 30),


            Observer(
              builder: (_) => StatisticsDetails(
                categoryStore: categoryStore,
                incomeStore: incomeStore,
                expenseStore: expenseStore,
              ),
            ),
          ],
        ),
      ),
    );
  }
}