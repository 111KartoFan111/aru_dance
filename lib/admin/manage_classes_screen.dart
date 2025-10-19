import 'package:flutter/material.dart';
import '../../widgets/image_with_fallback.dart';

class ManageClassesScreen extends StatefulWidget {
  const ManageClassesScreen({super.key});

  @override
  State<ManageClassesScreen> createState() => _ManageClassesScreenState();
}

class _ManageClassesScreenState extends State<ManageClassesScreen> {
  final List<Map<String, dynamic>> _classes = [
    {
      'id': '1',
      'name': 'Хип-хоп для начинающих',
      'instructor': 'Анна Петрова',
      'price': 800,
      'image': 'https://images.unsplash.com/photo-1609602961949-eddbb90383cc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxoaXAlMjBob3AlMjBkYW5jZXxlbnwxfHx8fDE3NjA3MjgwNDB8MA&ixlib=rb-4.1.0&q=80&w=1080',
    },
    {
      'id': '2',
      'name': 'Классический балет',
      'instructor': 'Елена Соколова',
      'price': 1200,
      'image': 'https://images.unsplash.com/photo-1495791185843-c73f2269f669?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxiYWxsZXQlMjBkYW5jZXJ8ZW58MXx8fHwxNzYwNzIyODQwfDA&ixlib=rb-4.1.0&q=80&w=1080',
    },
  ];

  void _showAddEditClassDialog({Map<String, dynamic>? danceClass}) {
    final isEditing = danceClass != null;
    final nameController = TextEditingController(text: isEditing ? danceClass['name'] : '');
    final instructorController = TextEditingController(text: isEditing ? danceClass['instructor'] : '');
    final priceController = TextEditingController(text: isEditing ? danceClass['price'].toString() : '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(isEditing ? 'Редактировать класс' : 'Добавить класс', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Название класса')),
              const SizedBox(height: 10),
              TextField(controller: instructorController, decoration: const InputDecoration(labelText: 'Инструктор')),
              const SizedBox(height: 10),
              TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Цена'), keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Класс ${isEditing ? 'обновлен' : 'добавлен'}')),
                    );
                  },
                  child: Text(isEditing ? 'Сохранить' : 'Добавить', style: const TextStyle(color: Colors.white)),
                ),
              ),
               const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Управление классами')),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _classes.length,
        itemBuilder: (context, index) {
          final danceClass = _classes[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ImageWithFallback(
                  imageUrl: danceClass['image'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(danceClass['name']),
              subtitle: Text('${danceClass['instructor']} - ₸${danceClass['price']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.edit), onPressed: () => _showAddEditClassDialog(danceClass: danceClass)),
                  IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () {}),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditClassDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
