import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Финансовые отчеты')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Общая статистика', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard('Общий доход', '₸1,250,000', Icons.monetization_on, Colors.green),
                _buildStatCard('Продано билетов', '845', Icons.confirmation_number, Colors.blue),
                _buildStatCard('Средний чек', '₸1,480', Icons.pie_chart, Colors.orange),
                _buildStatCard('Новых клиентов (мес)', '72', Icons.person_add, Colors.purple),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Последние транзакции', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ..._buildTransactionList(),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 32, color: color),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(title, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTransactionList() {
    final transactions = [
      {'user': 'Nurlankyzy Aru', 'class': 'Хип-хоп', 'amount': 800.0, 'date': '20.10.2025'},
      {'user': 'Иван Петров', 'class': 'Балет', 'amount': 1200.0, 'date': '19.10.2025'},
      {'user': 'Елена Сидорова', 'class': 'Сальса', 'amount': 900.0, 'date': '19.10.2025'},
    ];

    return transactions.map((tx) {
      return Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(tx['user'] as String),
          subtitle: Text('Класс: ${tx['class']} - ${tx['date']}'),
          trailing: Text('₸${tx['amount']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
        ),
      );
    }).toList();
  }
}
