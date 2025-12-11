import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import '../../store/expense_store.dart';


class ExpenseListScreen extends StatelessWidget {
  final ExpenseStore store;

  const ExpenseListScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Расходы'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Добавить расход',
            onPressed: () => context.push('/add-expense'),
          ),
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            tooltip: 'Перейти к пополнениям',
            onPressed: () => context.push('/incomes'),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (store.expenses.isEmpty) {
            return const Center(child: Text('Пока нет расходов'));
          }
          return ListView.builder(
            itemCount: store.expenses.length,
            itemBuilder: (context, i) {
              final tx = store.expenses[i];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(tx.imageUrl)),
                  title: Text(tx.title),
                  subtitle: Text(tx.source),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '-${tx.amount.toStringAsFixed(2)} ₽',
                        style: const TextStyle(color: Colors.red),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.grey),
                        onPressed: () => store.removeExpense(tx),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
