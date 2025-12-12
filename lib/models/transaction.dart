import 'package:flutter/material.dart';

class Transaction {
  final double amount;
  final String title;
  final String source;
  final bool isIncome;
  final String imageUrl;
  final String categoryId;
  final DateTime createdAt; // Добавляем дату создания

  Transaction({
    required this.amount,
    required this.title,
    required this.source,
    required this.isIncome,
    required this.imageUrl,
    required this.categoryId,
    DateTime? createdAt, // Делаем необязательным, по умолчанию будет текущее время
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'title': title,
      'source': source,
      'isIncome': isIncome,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'createdAt': createdAt.toIso8601String(), // Сохраняем дату
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: (json['amount'] as num).toDouble(),
      title: json['title'] as String,
      source: json['source'] as String,
      isIncome: json['isIncome'] as bool,
      imageUrl: json['imageUrl'] as String,
      categoryId: json['categoryId'] as String,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(), // Если нет даты, используем текущую
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Transaction &&
              runtimeType == other.runtimeType &&
              amount == other.amount &&
              title == other.title &&
              source == other.source &&
              isIncome == other.isIncome &&
              imageUrl == other.imageUrl &&
              categoryId == other.categoryId;

  @override
  int get hashCode =>
      amount.hashCode ^
      title.hashCode ^
      source.hashCode ^
      isIncome.hashCode ^
      imageUrl.hashCode ^
      categoryId.hashCode;
}