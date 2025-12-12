import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import '../../models/receipt.dart';
import '../../store/receipt_store.dart';
import '../../store/category_store.dart';
import '/di/service_locator.dart';

class ReceiptAddScreen extends StatefulWidget {
  const ReceiptAddScreen({Key? key}) : super(key: key);

  @override
  State<ReceiptAddScreen> createState() => _ReceiptAddScreenState();
}

class _ReceiptAddScreenState extends State<ReceiptAddScreen> {
  late ReceiptStore _receiptStore;
  late CategoryStore _categoryStore;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String? _selectedCategoryId;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _receiptStore = getIt<ReceiptStore>();
    _categoryStore = getIt<CategoryStore>();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showError('Ошибка при выборе изображения: $e');
    }
  }

  Future<void> _takePhoto() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showError('Ошибка при съемке фото: $e');
    }
  }

  void _saveReceipt() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text);

    if (title.isEmpty) {
      _showError('Введите название квитанции');
      return;
    }

    if (amount == null || amount <= 0) {
      _showError('Введите корректную сумму');
      return;
    }

    if (_selectedCategoryId == null) {
      _showError('Выберите категорию');
      return;
    }


    final receipt = Receipt(
      title: title,
      amount: amount,
      categoryId: _selectedCategoryId!,
      imagePath: _selectedImage?.path,
    );

    _receiptStore.addReceipt(receipt);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Квитанция сохранена')),
    );

    context.pop();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = _categoryStore.categories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить квитанцию'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Превью изображения
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text('Выбрать из галереи'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickImage();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text('Сделать фото'),
                          onTap: () {
                            Navigator.pop(context);
                            _takePhoto();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: _selectedImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                  ),
                )
                    : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_photo_alternate, size: 60, color: Colors.grey),
                    SizedBox(height: 12),
                    Text('Нажмите для выбора фото'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),


            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Название квитанции',
                hintText: 'Например: Чек на холодильник',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),


            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Сумма',
                border: OutlineInputBorder(),
                prefixText: '₽ ',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),


            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Категория',
                border: OutlineInputBorder(),
              ),
              value: _selectedCategoryId,
              onChanged: (String? value) {
                setState(() {
                  _selectedCategoryId = value;
                });
              },
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category.id,
                  child: Row(
                    children: [
                      Icon(category.icon, color: category.color, size: 20),
                      const SizedBox(width: 10),
                      Text(category.name),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),


            ElevatedButton(
              onPressed: _saveReceipt,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Сохранить квитанцию'),
            ),
            const SizedBox(height: 16),

            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Отмена'),
            ),
          ],
        ),
      ),
    );
  }
}