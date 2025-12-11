import 'package:mobx/mobx.dart';
import '../models/transaction.dart';

part 'income_store.g.dart';

class IncomeStore = _IncomeStore with _$IncomeStore;

abstract class _IncomeStore with Store {
  @observable
  ObservableList<Transaction> incomes = ObservableList<Transaction>();

  @action
  void setIncomes(List<Transaction> initialIncomes) {
    incomes.clear();
    incomes.addAll(initialIncomes);
  }

  @action
  void addIncome(Transaction income) {
    incomes.add(income);
  }

  @action
  void removeIncome(Transaction income) {
    incomes.remove(income);
  }
}
