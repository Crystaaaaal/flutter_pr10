import 'dart:io';
import 'package:flutter/material.dart';

class Receipt {
  final String id;
  final String title;
  final String? imagePath;
  final String? imageUrl;
  final DateTime createdAt;
  final double amount;
  final String categoryId;  

  Receipt({
    String? id,
    required this.title,
    this.imagePath,
    this.imageUrl,
    required this.amount,
    required this.categoryId,
    DateTime? createdAt,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt = createdAt ?? DateTime.now();

  bool get hasImage => imagePath != null || imageUrl != null;

  Widget getImageWidget({double width = 100, double height = 100}) {
    if (imagePath != null && File(imagePath!).existsSync()) {
      return Image.file(
        File(imagePath!),
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    } else {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[200],
        child: const Icon(Icons.receipt, color: Colors.grey),
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imagePath': imagePath,
      'imageUrl': imageUrl,
      'amount': amount,
      'categoryId': categoryId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      id: json['id'] as String,
      title: json['title'] as String,
      imagePath: json['imagePath'] as String?,
      imageUrl: json['imageUrl'] as String?,
      amount: (json['amount'] as num).toDouble(),
      categoryId: json['categoryId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Receipt &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}