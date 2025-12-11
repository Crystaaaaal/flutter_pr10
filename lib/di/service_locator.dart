import 'package:get_it/get_it.dart';
import 'package:pr7_2/store/category_store.dart';
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
  getIt.registerSingleton<CategoryStore>(CategoryStore());
  getIt.registerSingleton<BalanceStore>(
    BalanceStore(getIt<IncomeStore>(), getIt<ExpenseStore>()),
  );
  getIt.registerSingleton<TransactionFormStore>(TransactionFormStore());

  // Инициализируем дефолтные категории
  getIt<CategoryStore>().initializeDefaultCategories();
}

void loadInitialData() {
  final incomeStore = getIt<IncomeStore>();
  final expenseStore = getIt<ExpenseStore>();

  // Создаем начальные транзакции с categoryId
  final initialExpenses = [
    Transaction(
      amount: 1200,
      title: 'Продукты',
      source: 'Покупка еды в супермаркете',
      isIncome: false,
      imageUrl: 'https://images.thevoicemag.ru/upload/img_cache/493/493173ba9d947eb9624440f06237437e_cropped_666x444.jpg',
      categoryId: 'expense_food', // ID дефолтной категории для еды
    ),
    Transaction(
      amount: 350,
      title: 'Транспорт',
      source: 'Проезд на автобусе',
      isIncome: false,
      imageUrl: 'https://www.shutterstock.com/image-vector/transport-travel-car-train-bus-600w-506212144.jpg',
      categoryId: 'expense_transport', // ID дефолтной категории для транспорта
    ),
  ];

  final initialIncomes = [
    Transaction(
      amount: 50000,
      title: 'Зарплата',
      source: 'Основная работа',
      isIncome: true,
      imageUrl: 'https://img.gazeta.ru/files3/705/16249705/vkonvertr-pic_32ratio_1200x800-1200x800-79503.jpg',
      categoryId: 'income_salary', // ID дефолтной категории для зарплаты
    ),
    Transaction(
      amount: 7000,
      title: 'Фриланс',
      source: 'Проект по дизайну',
      isIncome: true,
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/1807/1807705.png',
      categoryId: 'income_freelance', // ID дефолтной категории для фриланса
    ),
  ];

  incomeStore.setIncomes(initialIncomes);
  expenseStore.setExpenses(initialExpenses);
}