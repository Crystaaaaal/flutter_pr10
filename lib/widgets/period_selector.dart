import 'package:flutter/material.dart';

class PeriodSelector extends StatelessWidget {
  final int selectedPeriod;
  final ValueChanged<int> onPeriodChanged;

  const PeriodSelector({
    Key? key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Период:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPeriodButton('Месяц', 0),
            _buildPeriodButton('Год', 1),
            _buildPeriodButton('Все время', 2),
          ],
        ),
      ],
    );
  }

  Widget _buildPeriodButton(String text, int index) {
    return ElevatedButton(
      onPressed: () => onPeriodChanged(index),
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedPeriod == index ? Colors.blue : Colors.grey[300],
        foregroundColor: selectedPeriod == index ? Colors.white : Colors.black,
      ),
      child: Text(text),
    );
  }
}