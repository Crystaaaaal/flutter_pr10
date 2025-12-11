import 'package:mobx/mobx.dart';
import 'expense_store.dart';
import 'income_store.dart';

part 'balance_store.g.dart';

class BalanceStore = _BalanceStore with _$BalanceStore;

abstract class _BalanceStore with Store {
  final IncomeStore incomeStore;
  final ExpenseStore expenseStore;

  _BalanceStore(this.incomeStore, this.expenseStore);

  @computed
  double get balance =>
      incomeStore.incomes.fold(0.0, (sum, tx) => sum + tx.amount) -
          expenseStore.expenses.fold(0.0, (sum, tx) => sum + tx.amount);
}
