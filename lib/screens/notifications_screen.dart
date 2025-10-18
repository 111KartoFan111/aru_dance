import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Уведомления'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNotificationItem(
            context,
            icon: Icons.calendar_today,
            color: Colors.blue,
            title: 'Напоминание о занятии',
            subtitle: 'Ваше занятие по хип-хопу начнется через 1 час.',
            time: '5м назад',
          ),
          _buildNotificationItem(
            context,
            icon: Icons.check_circle,
            color: Colors.green,
            title: 'Успешная оплата',
            subtitle: 'Оплата за занятие "Сальса для пар" прошла успешно.',
            time: '1ч назад',
          ),
          _buildNotificationItem(
            context,
            icon: Icons.new_releases,
            color: Colors.orange,
            title: 'Новое занятие',
            subtitle: 'В студии появилось новое направление - Бачата!',
            time: 'Вчера',
          ),
           _buildNotificationItem(
            context,
            icon: Icons.cancel,
            color: Colors.red,
            title: 'Отмена занятия',
            subtitle: 'Занятие по балету сегодня отменено.',
            time: '2 дня назад',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        onTap: () {},
      ),
    );
  }
}
