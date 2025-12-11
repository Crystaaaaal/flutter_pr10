import 'package:flutter/material.dart';

class Transaction {
  final double amount;
  final String title;
  final String source;
  final bool isIncome;
  final String imageUrl;

  Transaction({
    required this.amount,
    required this.title,
    required this.source,
    required this.isIncome,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'title': title,
      'source': source,
      'isIncome': isIncome,
      'imageUrl': imageUrl,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: (json['amount'] as num).toDouble(),
      title: json['title'] as String,
      source: json['source'] as String,
      isIncome: json['isIncome'] as bool,
      imageUrl: json['imageUrl'] as String,
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
              imageUrl == other.imageUrl;

  @override
  int get hashCode =>
      amount.hashCode ^
      title.hashCode ^
      source.hashCode ^
      isIncome.hashCode ^
      imageUrl.hashCode;
}
