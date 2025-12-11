import 'package:mobx/mobx.dart';
import '../models/transaction.dart';

part 'expense_store.g.dart';

class ExpenseStore = _ExpenseStore with _$ExpenseStore;

abstract class _ExpenseStore with Store {
  @observable
  ObservableList<Transaction> expenses = ObservableList<Transaction>();

  @action
  void setExpenses(List<Transaction> initialExpenses) {
    expenses.clear();
    expenses.addAll(initialExpenses);
  }

  @action
  void addExpense(Transaction expense) {
    expenses.add(expense);
  }

  @action
  void removeExpense(Transaction expense) {
    expenses.remove(expense);
  }
}
