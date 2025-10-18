import 'package:flutter/material.dart';
import 'payment_screen.dart';
import '../widgets/image_with_fallback.dart';


class ClassDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> classDetails;

  const ClassDetailsScreen({super.key, required this.classDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                classDetails['name'],
                style: const TextStyle(shadows: [Shadow(blurRadius: 10)]),
              ),
              background: ImageWithFallback(
                imageUrl: classDetails['image'],
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_back, color: Colors.black),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInstructorCard(),
                  const SizedBox(height: 20),
                  const Text('Описание', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text(
                    'Научитесь базовым движениям хип-хопа, включая изоляции, грувы и основные комбинации. Этот класс идеален для тех, кто только начинает свой путь в танцах.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  _buildDetailsGrid(),
                  const SizedBox(height: 20),
                   const Text('Расписание', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  _buildSchedule(),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: _buildBookingButton(context),
    );
  }

  Widget _buildInstructorCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1615794239747-49e7d398a930?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxkYW5jZSUyMGluc3RydWN0b3IlMjBwb3J0cmFpdHxlbnwxfHx8fDE3NjA2MjQ3NDZ8MA&ixlib=rb-4.1.0&q=80&w=1080'),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Анна Петрова', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Профессиональный танцор', style: TextStyle(color: Colors.grey)),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(' 4.9'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 2.5,
      children: [
        _buildDetailItem(icon: Icons.timer_outlined, title: 'Длительность', value: '90 минут'),
        _buildDetailItem(icon: Icons.attach_money, title: 'Цена', value: '₽800'),
        _buildDetailItem(icon: Icons.location_on_outlined, title: 'Место', value: 'Зал №2'),
        _buildDetailItem(icon: Icons.people_outline, title: 'Мест осталось', value: '5 из 15'),
      ],
    );
  }

  Widget _buildDetailItem({required IconData icon, required String title, required String value}) {
    return Card(
      color: Colors.grey[100],
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF9B59B6)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

   Widget _buildSchedule() {
    return const Column(
      children: [
        ListTile(title: Text('Понедельник'), trailing: Text('18:00 - 19:30')),
        ListTile(title: Text('Среда'), trailing: Text('18:00 - 19:30')),
        ListTile(title: Text('Пятница'), trailing: Text('19:00 - 20:30')),
      ],
    );
  }


  Widget _buildBookingButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () {
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentScreen(classDetails: classDetails)),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9B59B6),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Записаться на занятие', style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }
}
