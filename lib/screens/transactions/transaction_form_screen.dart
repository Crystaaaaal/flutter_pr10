import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../store/transaction_form_store.dart';
import '../../store/income_store.dart';
import '../../store/expense_store.dart';
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

  @override
  Widget build(BuildContext context) {
    final store = widget.store;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isIncome ? 'Добавить пополнение' : 'Добавить расход'),
      ),
      body: Padding(
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
              TextFormField(
                decoration: const InputDecoration(labelText: 'Источник'),
                onChanged: store.updateSource,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Сумма'),
                keyboardType: TextInputType.number,
                onChanged: store.updateAmount,
                validator: (v) => v == null || v.isEmpty ? 'Введите сумму' : null,
              ),
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
                child: Text(widget.isIncome ? 'Добавить пополнение' : 'Добавить расход'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
