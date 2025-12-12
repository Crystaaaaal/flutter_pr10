import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import '../../store/receipt_store.dart';
import '../../store/category_store.dart';
import '/di/service_locator.dart';

class ReceiptListScreen extends StatelessWidget {
  const ReceiptListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final receiptStore = getIt<ReceiptStore>();
    final categoryStore = getIt<CategoryStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Квитанции'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/receipts/add'),
            tooltip: 'Добавить квитанцию',
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          if (receiptStore.receipts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.receipt, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'Нет квитанций',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Добавьте первую квитанцию',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.push('/receipts/add'),
                    child: const Text('Добавить квитанцию'),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Статистика
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.receipt, color: Colors.blue),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Всего квитанций',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              '${receiptStore.receipts.length} шт.',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Общая сумма',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              '${receiptStore.totalAmount.toStringAsFixed(2)} ₽',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Список квитанций
                const Text(
                  'Все квитанции',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: receiptStore.receipts.length,
                    itemBuilder: (context, index) {
                      final receipt = receiptStore.receipts[index];
                      final category = categoryStore.getCategoryById(receipt.categoryId);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: receipt.getImageWidget(width: 60, height: 60),
                          title: Text(receipt.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(category?.name ?? 'Без категории'),
                              Text(
                                '${receipt.createdAt.day}.${receipt.createdAt.month}.${receipt.createdAt.year}',
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${receipt.amount.toStringAsFixed(2)} ₽',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Удалить квитанцию?'),
                                      content: Text('Вы уверены, что хотите удалить квитанцию "${receipt.title}"?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('Отмена'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            receiptStore.deleteReceipt(receipt.id);
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Квитанция удалена')),
                                            );
                                          },
                                          child: const Text(
                                            'Удалить',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          onTap: () {

                            context.push('/receipts/view', extra: receipt);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}