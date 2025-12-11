import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import '../../store/transaction_form_store.dart';
import '../../store/income_store.dart';
import '../../store/expense_store.dart';
import '../../store/category_store.dart';
import '../../di/service_locator.dart';

class TransactionFormScreen extends StatefulWidget {
  final bool isIncome;
  final TransactionFormStore store;

  const TransactionFormScreen({super.key, required this.isIncome, required this.store});

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late CategoryStore _categoryStore;

  @override
  void initState() {
    super.initState();
    _categoryStore = getIt<CategoryStore>();

    // Устанавливаем первую подходящую категорию по умолчанию
    final categories = _categoryStore.getCategoriesByType(!widget.isIncome);
    if (categories.isNotEmpty) {
      widget.store.updateCategoryId(categories.first.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = widget.store;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isIncome ? 'Добавить доход' : 'Добавить расход'),
        centerTitle: true,
      ),
      body: Observer(
        builder: (context) {
          final categories = _categoryStore.getCategoriesByType(!widget.isIncome);

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Название'),
                    onChanged: store.updateTitle,
                    validator: (v) => v == null || v.isEmpty ? 'Введите название' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Источник'),
                    onChanged: store.updateSource,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Сумма'),
                    keyboardType: TextInputType.number,
                    onChanged: store.updateAmount,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Введите сумму';
                      final amount = double.tryParse(v);
                      if (amount == null || amount <= 0) return 'Введите корректную сумму';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Выбор категории
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Категория'),
                    value: store.categoryId.isNotEmpty && categories.any((c) => c.id == store.categoryId)
                        ? store.categoryId
                        : null,
                    onChanged: (String? value) {
                      if (value != null) {
                        store.updateCategoryId(value);
                      }
                    },
                    items: categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category.id,
                        child: Row(
                          children: [
                            Icon(category.icon, color: category.color, size: 20),
                            const SizedBox(width: 10),
                            Text(category.name),
                          ],
                        ),
                      );
                    }).toList(),
                    validator: (value) => value == null || value.isEmpty ? 'Выберите категорию' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'URL картинки'),
                    onChanged: store.updateImageUrl,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        store.updateIsIncome(widget.isIncome);
                        final tx = store.createTransaction();

                        if (widget.isIncome) {
                          getIt<IncomeStore>().addIncome(tx);
                        } else {
                          getIt<ExpenseStore>().addExpense(tx);
                        }

                        context.pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: Text(widget.isIncome ? 'Добавить доход' : 'Добавить расход'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}