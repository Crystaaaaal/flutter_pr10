import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../store/balance_store.dart';
import '../widgets/balance_card.dart';
import '../di/service_locator.dart';

class ExpenseMainScreen extends StatelessWidget {
  final BalanceStore balanceStore;

  const ExpenseMainScreen({super.key, required this.balanceStore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Контроль расходов'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BalanceCard(store: balanceStore),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.push('/incomes'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Пополнения'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.push('/expenses'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Траты'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.push('/receipts'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Квитанции'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.push('/categories'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Категории'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.push('/statistics'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Статистика'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.push('/profile'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Профиль'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.push('/info'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('О приложении'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
