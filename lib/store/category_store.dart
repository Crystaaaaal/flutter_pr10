import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../models/category.dart';

part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  @observable
  ObservableList<Category> categories = ObservableList<Category>.of([
    Category(
      id: '1',
      name: 'Еда',
      icon: Icons.restaurant,
      color: Colors.orange,
      isExpense: true,
    ),
    Category(
      id: '2',
      name: 'Транспорт',
      icon: Icons.directions_car,
      color: Colors.blue,
      isExpense: true,
    ),
    Category(
      id: '3',
      name: 'Развлечения',
      icon: Icons.movie,
      color: Colors.purple,
      isExpense: true,
    ),
    Category(
      id: '4',
      name: 'Зарплата',
      icon: Icons.work,
      color: Colors.green,
      isExpense: false,
    ),
    // ... другие предустановленные категории
  ]);

  @action
  void addCategory(Category category) {
    categories.add(category);
  }

  @action
  void updateCategory(String id, Category newCategory) {
    final index = categories.indexWhere((cat) => cat.id == id);
    if (index != -1) {
      categories[index] = newCategory;
    }
  }

  @action
  void deleteCategory(String id) {
    categories.removeWhere((cat) => cat.id == id);
  }

  // Получить категории по типу (расходы или доходы)
  List<Category> getCategoriesByType(bool isExpense) {
    return categories.where((cat) => cat.isExpense == isExpense).toList();
  }

  // Метод для инициализации дефолтных категорий (если список пустой)
  void initializeDefaultCategories() {
    if (categories.isEmpty) {
      categories = ObservableList<Category>.of([
        Category(
          id: '1',
          name: 'Еда',
          icon: Icons.restaurant,
          color: Colors.orange,
          isExpense: true,
        ),
        Category(
          id: '2',
          name: 'Транспорт',
          icon: Icons.directions_car,
          color: Colors.blue,
          isExpense: true,
        ),
        Category(
          id: '3',
          name: 'Развлечения',
          icon: Icons.movie,
          color: Colors.purple,
          isExpense: true,
        ),
        Category(
          id: '4',
          name: 'Зарплата',
          icon: Icons.work,
          color: Colors.green,
          isExpense: false,
        ),
        // Добавляем еще несколько категорий для полноты
        Category(
          id: '5',
          name: 'Одежда',
          icon: Icons.shopping_bag,
          color: Colors.pink,
          isExpense: true,
        ),
        Category(
          id: '6',
          name: 'Фриланс',
          icon: Icons.computer,
          color: Colors.orange,
          isExpense: false,
        ),
      ]);
    }
  }

  // Метод для получения категории по ID
  Category? getCategoryById(String id) {
    try {
      return categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  // Метод для получения категории по имени (опционально, но полезно)
  Category? getCategoryByName(String name) {
    try {
      return categories.firstWhere((category) => category.name == name);
    } catch (e) {
      return null;
    }
  }
}