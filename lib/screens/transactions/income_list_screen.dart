import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import '../../store/income_store.dart';
import '../../di/service_locator.dart';

class IncomeListScreen extends StatelessWidget {
  final IncomeStore store;

  const IncomeListScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Пополнения'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Добавить пополнение',
            onPressed: () => context.push('/add-income'),
          ),
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            tooltip: 'Перейти к расходам',
            onPressed: () => context.push('/expenses'),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (store.incomes.isEmpty) {
            return const Center(child: Text('Пока нет пополнений'));
          }
          return ListView.builder(
            itemCount: store.incomes.length,
            itemBuilder: (context, i) {
              final tx = store.incomes[i];
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
                        '+${tx.amount.toStringAsFixed(2)} ₽',
                        style: const TextStyle(color: Colors.green),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => store.removeIncome(tx),
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
