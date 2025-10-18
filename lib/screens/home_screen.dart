import 'package:flutter/material.dart';
import 'class_details_screen.dart';
import 'schedule_screen.dart';
import 'profile_screen.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/image_with_fallback.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const ScheduleScreen(),
    const ProfileScreen(),
  ];

  void _onNavigate(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNav(
        activeScreen: _mapIndexToScreenName(_currentIndex),
        onNavigate: (screenName) {
          _onNavigate(_mapScreenNameTOIndex(screenName));
        },
      ),
    );
  }

  String _mapIndexToScreenName(int index) {
    switch (index) {
      case 0:
        return 'home';
      case 1:
        return 'schedule';
      case 2:
        return 'profile';
      default:
        return 'home';
    }
  }

   int _mapScreenNameTOIndex(String screenName) {
    switch (screenName) {
      case 'home':
        return 0;
      case 'schedule':
        return 1;
      case 'profile':
        return 2;
      default:
        return 0;
    }
  }
}


class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final danceClasses = [
      {
        'id': '1',
        'name': 'Хип-хоп для начинающих',
        'instructor': 'Анна Петрова',
        'level': 'Начальный',
        'image': 'https://images.unsplash.com/photo-1609602961949-eddbb90383cc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxoaXAlMjBob3AlMjBkYW5jZXxlbnwxfHx8fDE3NjA3MjgwNDB8MA&ixlib=rb-4.1.0&q=80&w=1080',
        'popular': true,
        'category': 'Современные',
      },
      {
        'id': '2',
        'name': 'Классический балет',
        'instructor': 'Елена Соколова',
        'level': 'Средний',
        'image': 'https://images.unsplash.com/photo-1495791185843-c73f2269f669?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxiYWxsZXQlMjBkYW5jZXJ8ZW58MXx8fHwxNzYwNzI4MDQwfDA&ixlib=rb-4.1.0&q=80&w=1080',
        'popular': false,
        'category': 'Классические',
      },
      {
        'id': '3',
        'name': 'Сальса для пар',
        'instructor': 'Карлос Родригес',
        'level': 'Начальный',
        'image': 'https://images.unsplash.com/photo-1504609813442-a8924e83f76e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzYWxzYSUyMGRhbmNpbmd8ZW58MXx8fHwxNzYwNzI4MDQwfDA&ixlib=rb-4.1.0&q=80&w=1080',
        'popular': true,
        'category': 'Латина',
      },
    ];

    final categories = ['Все', 'Современные', 'Классические', 'Латина'];

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Найди свой стиль',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Выбери направление и начни танцевать',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Поиск танцевальных классов...',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Chip(
                        label: Text(categories[index]),
                        backgroundColor: index == 0 ? const Color(0xFF9B59B6) : Colors.white,
                        labelStyle: TextStyle(
                          color: index == 0 ? Colors.white : Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final danceClass = danceClasses[index];
                    return DanceClassCard(
                      danceClass: danceClass,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClassDetailsScreen(
                              classDetails: danceClass,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  childCount: danceClasses.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DanceClassCard extends StatelessWidget {
  final Map<String, dynamic> danceClass;
  final VoidCallback onTap;

  const DanceClassCard({
    super.key,
    required this.danceClass,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ImageWithFallback(
                  imageUrl: danceClass['image'],
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: danceClass['popular']
                      ? const Chip(
                    label: Text('Популярно'),
                    backgroundColor: Color(0xFFEC87C0),
                    labelStyle: TextStyle(color: Colors.white),
                  )
                      : Container(),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        danceClass['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        danceClass['instructor'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(danceClass['level']),
                    backgroundColor: Colors.grey[200],
                  ),
                  Text(
                    danceClass['category'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
