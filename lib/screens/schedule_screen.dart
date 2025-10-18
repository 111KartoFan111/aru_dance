import 'package:flutter/material.dart';
import '../widgets/image_with_fallback.dart';


class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Моё расписание', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF9B59B6),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF9B59B6),
          tabs: const [
            Tab(text: 'Предстоящие'),
            Tab(text: 'Прошедшие'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildClassList(isUpcoming: true),
          _buildClassList(isUpcoming: false),
        ],
      ),
    );
  }

  Widget _buildClassList({required bool isUpcoming}) {
    final classes = isUpcoming ? upcomingClasses : pastClasses;
    if (classes.isEmpty) {
      return const Center(child: Text('Нет занятий'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: classes.length,
      itemBuilder: (context, index) {
        return ClassScheduleCard(classInfo: classes[index], isUpcoming: isUpcoming);
      },
    );
  }
}

class ClassScheduleCard extends StatelessWidget {
  final Map<String, dynamic> classInfo;
  final bool isUpcoming;

  const ClassScheduleCard({super.key, required this.classInfo, required this.isUpcoming});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ImageWithFallback(
                    imageUrl: classInfo['image'],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(classInfo['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(classInfo['instructor'], style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 10),
                      _buildInfoRow(icon: Icons.calendar_today, text: classInfo['date']),
                      _buildInfoRow(icon: Icons.access_time, text: classInfo['time']),
                      _buildInfoRow(icon: Icons.location_on, text: classInfo['location']),
                    ],
                  ),
                ),
              ],
            ),
            if (!isUpcoming) const SizedBox(height: 10),
            if (!isUpcoming)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Оставить отзыв'),
                    ),
                  ),
                  const SizedBox(width: 10),
                   Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF9B59B6)),
                      child: const Text('Записаться снова', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

final upcomingClasses = [
    {
      'id': '1',
      'name': 'Хип-хоп для начинающих',
      'instructor': 'Анна Петрова',
      'date': 'Понедельник, 20 октября',
      'time': '18:00 - 19:30',
      'location': 'Зал №2',
      'image': 'https://images.unsplash.com/photo-1609602961949-eddbb90383cc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxoaXAlMjBob3AlMjBkYW5jZXxlbnwxfHx8fDE3NjA3MjgwNDB8MA&ixlib=rb-4.1.0&q=80&w=1080',
      'status': 'confirmed',
    },
];

final pastClasses = [
   {
      'id': '3',
      'name': 'Классический балет',
      'instructor': 'Елена Соколова',
      'date': 'Пятница, 17 октября',
      'time': '17:00 - 18:30',
      'location': 'Зал №3',
      'image': 'https://images.unsplash.com/photo-1495791185843-c73f2269f669?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxiYWxsZXQlMjBkYW5jZXJ8ZW58MXx8fHwxNzYwNzI4MDQwfDA&ixlib=rb-4.1.0&q=80&w=1080',
      'status': 'completed',
    },
];
