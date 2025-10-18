import 'package:flutter/material.dart';
import '../widgets/image_with_fallback.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildStatsCard(),
              const SizedBox(height: 20),
              _buildMenuItems(context),
              const SizedBox(height: 20),
              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return const Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage('https://images.unsplash.com/photo-1555634599-459fed78173a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxkYW5jZSUyMHRlYWNoZXIlMjB3b21hbnxlbnwxfHx8fDE3NjA3MjgwNDF8MA&ixlib=rb-4.1.0&q=80&w=1080'),
        ),
        SizedBox(height: 10),
        Text('Мария Иванова', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text('maria.ivanova@email.com', style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildStatsCard() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StatItem(value: '24', label: 'Занятий'),
            StatItem(value: '36', label: 'Часов'),
            StatItem(value: '5', label: 'Достижений'),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        MenuItem(icon: Icons.person_outline, title: 'Редактировать профиль', onTap: () {}),
        MenuItem(icon: Icons.notifications_none, title: 'Уведомления', trailing: Switch(value: true, onChanged: (val) {})),
        MenuItem(icon: Icons.credit_card, title: 'Способы оплаты', onTap: () {}),
        MenuItem(icon: Icons.favorite_border, title: 'Избранное', onTap: () {}),
        MenuItem(icon: Icons.settings_outlined, title: 'Настройки', onTap: () {}),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.logout, color: Colors.red),
        label: const Text('Выйти из аккаунта', style: TextStyle(color: Colors.red)),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  final String value;
  final String label;

  const StatItem({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const MenuItem({super.key, required this.icon, required this.title, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing ?? (onTap != null ? const Icon(Icons.arrow_forward_ios, size: 16) : null),
      onTap: onTap,
    );
  }
}
