import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Аккаунт'),
            subtitle: Text('Настройки безопасности, смена пароля'),
          ),
          const ListTile(
            leading: Icon(Icons.palette_outlined),
            title: Text('Внешний вид'),
            subtitle: Text('Темная/светлая тема'),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: const Text('Push-уведомления'),
            value: true,
            onChanged: (bool value) {},
          ),
          const ListTile(
            leading: Icon(Icons.language),
            title: Text('Язык'),
            subtitle: Text('Русский'),
          ),
           const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('О приложении'),
            subtitle: Text('Версия 1.0.0'),
          ),
        ],
      ),
    );
  }
}
