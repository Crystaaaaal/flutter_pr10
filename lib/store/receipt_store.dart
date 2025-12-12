
import 'dart:io';
import 'package:mobx/mobx.dart';
import '../models/receipt.dart';


part 'receipt_store.g.dart';

class ReceiptStore = _ReceiptStore with _$ReceiptStore;

abstract class _ReceiptStore with Store {
  @observable
  ObservableList<Receipt> receipts = ObservableList<Receipt>();

  @action
  void addReceipt(Receipt receipt) {
    receipts.add(receipt);
  }

  @action
  void updateReceipt(String id, Receipt newReceipt) {
    final index = receipts.indexWhere((r) => r.id == id);
    if (index != -1) {
      receipts[index] = newReceipt;
    }
  }

  @action
  void deleteReceipt(String id) {
    // Удаляем файл изображения, если он существует
    final receipt = receipts.firstWhere((r) => r.id == id);
    if (receipt.imagePath != null) {
      try {
        final file = File(receipt.imagePath!);
        if (file.existsSync()) {
          file.deleteSync();
        }
      } catch (e) {
        print('Ошибка при удалении файла: $e');
      }
    }

    receipts.removeWhere((r) => r.id == id);
  }


  List<Receipt> getReceiptsByCategory(String categoryId) {
    return receipts.where((r) => r.categoryId == categoryId).toList();
  }


  List<Receipt> getRecentReceipts({int limit = 10}) {
    final sorted = receipts.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted.take(limit).toList();
  }


  double get totalAmount {
    return receipts.fold(0.0, (sum, receipt) => sum + receipt.amount);
  }
}