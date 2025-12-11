import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final bool isExpense; // true для расходов, false для доходов

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.isExpense,
  });
}