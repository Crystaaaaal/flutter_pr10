import 'package:go_router/go_router.dart';
import 'screens/info/info_screen.dart';
import 'screens/transactions/income_list_screen.dart';
import 'screens/transactions/expense_list_screen.dart';
import 'screens/transactions/transaction_form_screen.dart';
import 'screens/main_screen.dart';
import 'screens/authentication/enter_screen.dart';
import 'screens/authentication/registration_screen.dart';
import 'screens/authentication/profile_screen.dart';
import 'di/service_locator.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginScreen(userStore: getIt()), //LoginScreen(userStore: getIt()), ExpenseMainScreen(balanceStore: getIt()
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => ExpenseMainScreen(balanceStore: getIt()),
    ),
    GoRoute(
      path: '/incomes',
      builder: (context, state) => IncomeListScreen(store: getIt()),
    ),
    GoRoute(
      path: '/expenses',
      builder: (context, state) => ExpenseListScreen(store: getIt()),
    ),
    GoRoute(
      path: '/add-income',
      builder: (context, state) => TransactionFormScreen(isIncome: true, store: getIt()),
    ),
    GoRoute(
      path: '/add-expense',
      builder: (context, state) => TransactionFormScreen(isIncome: false, store: getIt()),
    ),
    GoRoute(
      path: '/info',
      builder: (context, state) => InfoAppScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(userStore: getIt()),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(userStore: getIt()),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(userStore: getIt()),
    ),
  ],
);
