import 'package:flutter/material.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  final List<Map<String, String>> _users = [
    {'id': '1', 'name': 'Nurlankyzy Aru', 'email': 'Aruaruzhiyee7@gmail.com', 'role': 'Студент'},
    {'id': '2', 'name': 'Иван Петров', 'email': 'ivan.p@example.com', 'role': 'Студент'},
    {'id': '3', 'name': 'Елена Сидорова', 'email': 'elena.s@example.com', 'role': 'Студент'},
  ];

  void _showAddEditUserDialog({Map<String, String>? user}) {
    final isEditing = user != null;
    final nameController = TextEditingController(text: isEditing ? user['name'] : '');
    final emailController = TextEditingController(text: isEditing ? user['email'] : '');
    String selectedRole = isEditing ? user['role']! : 'Студент';

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
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(isEditing ? 'Редактировать пользователя' : 'Добавить пользователя', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Имя')),
                  const SizedBox(height: 10),
                  TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedRole,
                    decoration: const InputDecoration(labelText: 'Роль'),
                    items: ['Студент', 'Инструктор', 'Администратор']
                        .map((role) => DropdownMenuItem(value: role, child: Text(role)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setModalState(() {
                          selectedRole = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Логика сохранения
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Пользователь ${isEditing ? 'обновлен' : 'добавлен'}')),
                        );
                      },
                      child: Text(isEditing ? 'Сохранить' : 'Добавить', style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить пользователя?'),
        content: Text('Вы уверены, что хотите удалить пользователя "${_users[index]['name']}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _users.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Пользователь удален')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Удалить', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Управление пользователями')),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(user['name']!),
            subtitle: Text('${user['email']} - ${user['role']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: const Icon(Icons.edit), onPressed: () => _showAddEditUserDialog(user: user)),
                IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _showDeleteConfirmationDialog(index)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditUserDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
