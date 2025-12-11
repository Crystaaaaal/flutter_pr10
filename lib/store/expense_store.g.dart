// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExpenseStore on _ExpenseStore, Store {
  late final _$expensesAtom = Atom(
    name: '_ExpenseStore.expenses',
    context: context,
  );

  @override
  ObservableList<Transaction> get expenses {
    _$expensesAtom.reportRead();
    return super.expenses;
  }

  @override
  set expenses(ObservableList<Transaction> value) {
    _$expensesAtom.reportWrite(value, super.expenses, () {
      super.expenses = value;
    });
  }

  late final _$_ExpenseStoreActionController = ActionController(
    name: '_ExpenseStore',
    context: context,
  );

  @override
  void setExpenses(List<Transaction> initialExpenses) {
    final _$actionInfo = _$_ExpenseStoreActionController.startAction(
      name: '_ExpenseStore.setExpenses',
    );
    try {
      return super.setExpenses(initialExpenses);
    } finally {
      _$_ExpenseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addExpense(Transaction expense) {
    final _$actionInfo = _$_ExpenseStoreActionController.startAction(
      name: '_ExpenseStore.addExpense',
    );
    try {
      return super.addExpense(expense);
    } finally {
      _$_ExpenseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeExpense(Transaction expense) {
    final _$actionInfo = _$_ExpenseStoreActionController.startAction(
      name: '_ExpenseStore.removeExpense',
    );
    try {
      return super.removeExpense(expense);
    } finally {
      _$_ExpenseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
expenses: ${expenses}
    ''';
  }
}
