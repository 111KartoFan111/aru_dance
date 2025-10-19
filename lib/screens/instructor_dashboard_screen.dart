import 'package:flutter/material.dart';
import '../instructor/my_students_screen.dart';
import '../instructor/statistics_screen.dart';
import '../admin/manage_classes_screen.dart';

class InstructorDashboardScreen extends StatelessWidget {
  const InstructorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Панель преподавателя',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black87),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInstructorProfile(),
            const SizedBox(height: 24),
            _buildUpcomingClasses(context),
            const SizedBox(height: 24),
            _buildQuickActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructorProfile() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF9B59B6).withOpacity(0.1),
            const Color(0xFFD4A5E8).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1615794239747-49e7d398a930?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxkYW5jZSUyMGluc3RydWN0b3IlMjBwb3J0cmFpdHxlbnwxfHx8fDE3NjA2MjQ3NDZ8MA&ixlib=rb-4.1.0&q=80&w=1080',
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Анна Петрова',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text('Хип-хоп инструктор', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingClasses(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Предстоящие занятия',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildClassCard(
          context,
          time: '18:00 - 19:30',
          title: 'Хип-хоп для начинающих',
          students: 12,
          maxStudents: 15,
        ),
        const SizedBox(height: 12),
        _buildClassCard(
          context,
          time: '20:00 - 21:30',
          title: 'Хип-хоп продвинутый',
          students: 8,
          maxStudents: 12,
        ),
      ],
    );
  }

  Widget _buildClassCard(
    BuildContext context, {
    required String time,
    required String title,
    required int students,
    required int maxStudents,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$time / $students из $maxStudents студентов'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {},
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Быстрые действия',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: [
            _buildActionCard(
              context,
              icon: Icons.edit_calendar,
              label: 'Мои классы',
              color: Colors.purple,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageClassesScreen())),
            ),
            _buildActionCard(
              context,
              icon: Icons.people_outline,
              label: 'Мои студенты',
              color: Colors.green,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyStudentsScreen())),
            ),
            _buildActionCard(
              context,
              icon: Icons.bar_chart,
              label: 'Статистика',
              color: Colors.orange,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InstructorStatisticsScreen())),
            ),
             _buildActionCard(
              context,
              icon: Icons.add_circle_outline,
              label: 'Создать занятие',
              color: Colors.blue,
              onTap: () {
                // Здесь можно вызвать модальное окно, как в ManageClassesScreen
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
           boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
