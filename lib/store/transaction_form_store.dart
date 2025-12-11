import 'package:mobx/mobx.dart';
import '../models/transaction.dart';

part 'transaction_form_store.g.dart';

class TransactionFormStore = _TransactionFormStore with _$TransactionFormStore;

abstract class _TransactionFormStore with Store {
  @observable
  String title = '';

  @observable
  String source = '';

  @observable
  double amount = 0;

  @observable
  String imageUrl = '';

  @observable
  bool isIncome = true;

  @action
  void updateTitle(String value) => title = value;

  @action
  void updateSource(String value) => source = value;

  @action
  void updateAmount(String value) => amount = double.tryParse(value) ?? 0;

  @action
  void updateImageUrl(String value) => imageUrl = value;

  @action
  void updateIsIncome(bool value) => isIncome = value;

  Transaction createTransaction() {
    return Transaction(
      title: title,
      source: source,
      amount: amount,
      imageUrl: imageUrl.isNotEmpty ? imageUrl : 'https://via.placeholder.com/100',
      isIncome: isIncome,
    );
  }
}
