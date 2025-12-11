import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import '../../store/category_store.dart';

class CategoriesScreen extends StatelessWidget {
  final CategoryStore categoryStore;

  const CategoriesScreen({Key? key, required this.categoryStore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/categories/add'),
            tooltip: 'Добавить категорию',
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          if (categoryStore.categories.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.category, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'Нет категорий',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Нажмите на плюсик вверху, чтобы добавить',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: categoryStore.categories.length,
            itemBuilder: (context, index) {
              final category = categoryStore.categories[index];
              return ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: category.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(category.icon, color: category.color),
                ),
                title: Text(category.name),
                subtitle: Text(category.isExpense ? 'Расход' : 'Доход'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => context.go('/categories/edit', extra: category),
                ),
                onTap: () {
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Удалить категорию?'),
                      content: Text('Вы уверены, что хотите удалить категорию "${category.name}"?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Отмена'),
                        ),
                        TextButton(
                          onPressed: () {
                            categoryStore.deleteCategory(category.id);
                            Navigator.pop(context);
                            // Показываем уведомление об удалении
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Категория "${category.name}" удалена'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Text('Удалить', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}