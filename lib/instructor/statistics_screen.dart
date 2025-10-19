import 'package:flutter/material.dart';

class InstructorStatisticsScreen extends StatelessWidget {
  const InstructorStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Моя статистика')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Обзор за месяц', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildStatCard('Доход', '₸85,000', Icons.monetization_on, Colors.green),
                _buildStatCard('Проведено занятий', '24', Icons.class_, Colors.blue),
                _buildStatCard('Всего студентов', '42', Icons.people, Colors.orange),
                _buildStatCard('Средний рейтинг', '4.9/5.0', Icons.star, Colors.purple),
              ],
            ),
             const SizedBox(height: 32),
            const Text('Самые популярные классы', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildPopularClassCard('Хип-хоп для начинающих', '28 студентов'),
            _buildPopularClassCard('Хип-хоп продвинутый', '14 студентов'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: color),
            const Spacer(),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(title, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularClassCard(String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.local_fire_department, color: Colors.orange),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
