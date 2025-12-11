import 'package:get_it/get_it.dart';
import '../store/income_store.dart';
import '../store/expense_store.dart';
import '../store/balance_store.dart';
import '../store/transaction_form_store.dart';
import '../models/transaction.dart';
import '../store/user_store.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<UserStore>(UserStore());
  getIt.registerSingleton<IncomeStore>(IncomeStore());
  getIt.registerSingleton<ExpenseStore>(ExpenseStore());
  getIt.registerSingleton<BalanceStore>(
    BalanceStore(getIt<IncomeStore>(), getIt<ExpenseStore>()),
  );
  getIt.registerSingleton<TransactionFormStore>(TransactionFormStore());
}


void loadInitialData() {
  final incomeStore = getIt<IncomeStore>();
  final expenseStore = getIt<ExpenseStore>();

  incomeStore.setIncomes(initialIncomes);
  expenseStore.setExpenses(initialExpenses);
}


final initialExpenses = [
  Transaction(
    amount: 1200,
    title: 'Продукты',
    source: 'Покупка еды в супермаркете',
    isIncome: false,
    imageUrl: 'https://images.thevoicemag.ru/upload/img_cache/493/493173ba9d947eb9624440f06237437e_cropped_666x444.jpg',
  ),
  Transaction(
    amount: 350,
    title: 'Транспорт',
    source: 'Проезд на автобусе',
    isIncome: false,
    imageUrl: 'https://www.shutterstock.com/image-vector/transport-travel-car-train-bus-600w-506212144.jpg',
  ),
];

final initialIncomes = [
  Transaction(
    amount: 50000,
    title: 'Зарплата',
    source: 'Основная работа',
    isIncome: true,
    imageUrl: 'https://img.gazeta.ru/files3/705/16249705/vkonvertr-pic_32ratio_1200x800-1200x800-79503.jpg',
  ),
  Transaction(
    amount: 7000,
    title: 'Фриланс',
    source: 'Проект по дизайну',
    isIncome: true,
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/1807/1807705.png',
  ),
];
