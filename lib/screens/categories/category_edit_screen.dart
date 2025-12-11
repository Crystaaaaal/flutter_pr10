
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/models/category.dart';
import '../../store/category_store.dart';

class CategoryEditScreen extends StatefulWidget {
  final CategoryStore categoryStore;
  final Category? category; // если null, то добавление, иначе редактирование

  const CategoryEditScreen({
    Key? key,
    required this.categoryStore,
    this.category,
  }) : super(key: key);

  @override
  _CategoryEditScreenState createState() => _CategoryEditScreenState();
}

class _CategoryEditScreenState extends State<CategoryEditScreen> {
  late TextEditingController _nameController;
  late bool _isExpense;
  IconData _selectedIcon = Icons.category;
  Color _selectedColor = Colors.blue;

  // Предопределенные иконки и цвета для выбора
  final List<IconData> _icons = [
    Icons.restaurant,
    Icons.directions_car,
    Icons.movie,
    Icons.work,
    Icons.home,
    Icons.shopping_cart,
    Icons.local_hospital,
    Icons.school,
    Icons.sports,
    Icons.phone,
  ];

  final List<Color> _colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.grey,
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category?.name ?? '');
    _isExpense = widget.category?.isExpense ?? true;
    _selectedIcon = widget.category?.icon ?? Icons.category;
    _selectedColor = widget.category?.color ?? Colors.blue;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveCategory() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите название категории')),
      );
      return;
    }

    final category = Category(
      id: widget.category?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      icon: _selectedIcon,
      color: _selectedColor,
      isExpense: _isExpense,
    );

    if (widget.category == null) {
      widget.categoryStore.addCategory(category);
    } else {
      widget.categoryStore.updateCategory(widget.category!.id, category);
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category == null ? 'Добавить категорию' : 'Редактировать категорию'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Название категории',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Тип: '),
                ChoiceChip(
                  label: const Text('Расход'),
                  selected: _isExpense,
                  onSelected: (selected) => setState(() => _isExpense = true),
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text('Доход'),
                  selected: !_isExpense,
                  onSelected: (selected) => setState(() => _isExpense = false),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Выберите иконку:'),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _icons.length,
                itemBuilder: (context, index) {
                  return IconButton(
                    icon: Icon(_icons[index]),
                    color: _selectedIcon == _icons[index] ? _selectedColor : Colors.grey,
                    onPressed: () => setState(() => _selectedIcon = _icons[index]),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text('Выберите цвет:'),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _colors.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = _colors[index]),
                    child: Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _colors[index],
                        shape: BoxShape.circle,
                        border: _selectedColor == _colors[index]
                            ? Border.all(color: Colors.black, width: 3)
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _saveCategory,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}