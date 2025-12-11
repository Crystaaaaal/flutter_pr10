import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import '../../store/income_store.dart';
import '../../store/category_store.dart';
import '../../di/service_locator.dart';

class IncomeListScreen extends StatelessWidget {
  final IncomeStore store;

  const IncomeListScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final categoryStore = getIt<CategoryStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Доходы'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Добавить доход',
            onPressed: () => context.push('/add-income'),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (store.incomes.isEmpty) {
            return const Center(child: Text('Пока нет доходов'));
          }
          return ListView.builder(
            itemCount: store.incomes.length,
            itemBuilder: (context, i) {
              final tx = store.incomes[i];
              final category = categoryStore.getCategoryById(tx.categoryId);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: category?.color.withOpacity(0.1) ?? Colors.grey[200],
                    child: Icon(
                      category?.icon ?? Icons.attach_money,
                      color: category?.color ?? Colors.green,
                    ),
                  ),
                  title: Text(tx.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tx.source),
                      if (category != null)
                        Text(
                          category.name,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '+${tx.amount.toStringAsFixed(2)} ₽',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
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