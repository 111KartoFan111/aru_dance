import 'package:flutter/material.dart';
import 'home_screen.dart';


class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF9B59B6), size: 100),
              const SizedBox(height: 20),
              const Text('Успешно записано!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Text('Мы отправили подтверждение на вашу почту', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 30),
              _buildDetailsCard(),
               const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download), label: const Text('Скачать'))),
                  const SizedBox(width: 10),
                  Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.share), label: const Text('Поделиться'))),
                ],
              ),
               const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                   style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9B59B6),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: const Text('Вернуться на главную', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Хип-хоп для начинающих', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Анна Петрова', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            DetailRow(icon: Icons.calendar_today, label: 'Дата', value: 'Понедельник, 20 октября'),
            DetailRow(icon: Icons.access_time, label: 'Время', value: '18:00 - 19:30'),
            DetailRow(icon: Icons.location_on, label: 'Место', value: 'Студия DanceFlow, зал №2'),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const DetailRow({super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}
