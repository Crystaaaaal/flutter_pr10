import 'package:flutter/material.dart';

class InfoAppScreen extends StatelessWidget {
  const InfoAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('О приложении'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок
            Text(
              'Мои финансы',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Приложение для учёта доходов и расходов',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 24),

            // Версия
            Text(
              'Версия',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Версия: 1.0.0\nДата сборки: 05.12.2025',
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 24),

            // Как пользоваться
            Text(
              'Как пользоваться',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1. Добавляйте свои доходы и расходы на экране транзакций.\n'
                  '2. Используйте категории, чтобы понимать, на что уходят деньги.\n'
                  '3. Смотрите баланс по счетам на экране кошельков.',
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 24),

            // Подсказки
            Text(
              'Подсказки',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '• Регулярно заносите операции, чтобы данные были точными.\n'
                  '• Используйте экспорт, чтобы сохранить данные или посмотреть их в таблице.\n'
                  '• Настройте категории под свои реальные траты.',
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 24),

            // О проекте
            Text(
              'О проекте',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Это учебное приложение, созданное для отработки навыков разработки и '
                  'проектирования бизнес-экранов. Структура и функциональность могут '
                  'меняться в процессе обучения.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
