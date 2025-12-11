import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  String? userEmail;

  @observable
  String userName = '';

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;  // ✅ Это String или null

  @observable
  bool isAuthenticated = false;

  @action
  Future<void> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    try {
      await Future.delayed(Duration(seconds: 1));

      if (email.isEmpty || password.isEmpty) {
        throw Exception('Заполните все поля');
      }

      if (password.length < 6) {
        throw Exception('Пароль должен быть минимум 6 символов');
      }

      userEmail = email;
      userName = email.split('@')[0];
      isAuthenticated = true;
    } catch (e) {
      // ✅ Правильно: преобразуем в String
      errorMessage = e.toString();
      isAuthenticated = false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> register(String email, String password, String confirmPassword) async {
    isLoading = true;
    errorMessage = null;
    try {
      await Future.delayed(Duration(seconds: 1));

      if (email.isEmpty || password.isEmpty) {
        throw Exception('Заполните все поля');
      }

      if (password != confirmPassword) {
        throw Exception('Пароли не совпадают');
      }

      if (password.length < 6) {
        throw Exception('Пароль должен быть минимум 6 символов');
      }

      userEmail = email;
      userName = email.split('@')[0];
      isAuthenticated = true;
    } catch (e) {
      // ✅ Правильно: преобразуем в String
      errorMessage = e.toString();
      isAuthenticated = false;
    } finally {
      isLoading = false;
    }
  }

  @action
  void logout() {
    userEmail = null;
    userName = '';
    isAuthenticated = false;
    errorMessage = null;
  }

  @action
  Future<void> updateProfile(String newName) async {
    isLoading = true;
    errorMessage = null;
    try {
      await Future.delayed(Duration(seconds: 1));

      if (newName.isEmpty) {
        throw Exception('Имя не может быть пустым');
      }

      userName = newName;
    } catch (e) {
      // ✅ Правильно: преобразуем в String
      errorMessage = e.toString();
      isAuthenticated = false;
    } finally {
      isLoading = false;
    }
  }
}
