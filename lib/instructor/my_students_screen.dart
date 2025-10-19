import 'package:flutter/material.dart';

class MyStudentsScreen extends StatelessWidget {
  const MyStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final students = [
      {'name': 'Nurlankyzy Aru', 'class': 'Хип-хоп для начинающих'},
      {'name': 'Иван Петров', 'class': 'Хип-хоп для начинающих'},
      {'name': 'Мария Иванова', 'class': 'Хип-хоп продвинутый'},
      {'name': 'Алексей Смирнов', 'class': 'Хип-хоп для начинающих'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои студенты'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(student['name']![0]),
              ),
              title: Text(student['name']!),
              subtitle: Text(student['class']!),
              trailing: IconButton(
                icon: const Icon(Icons.message_outlined),
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Написать сообщение ${student['name']}')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
