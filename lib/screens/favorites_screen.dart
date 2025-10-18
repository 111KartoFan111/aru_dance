import 'package:flutter/material.dart';
import '../widgets/image_with_fallback.dart';
import 'class_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteClasses = [
       {
        'id': '3',
        'name': 'Сальса для пар',
        'instructor': 'Карлос Родригес',
        'level': 'Начальный',
        'image': 'https://images.unsplash.com/photo-1504609813442-a8924e83f76e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzYWxzYSUyMGRhbmNpbmd8ZW58MXx8fHwxNzYwNzI4MDQwfDA&ixlib=rb-4.1.0&q=80&w=1080',
        'popular': true,
        'category': 'Латина',
        'rating': '5.0',
        'students': '156',
        'price': 900,
      },
       {
        'id': '1',
        'name': 'Хип-хоп для начинающих',
        'instructor': 'Анна Петрова',
        'level': 'Начальный',
        'image': 'https://images.unsplash.com/photo-1609602961949-eddbb90383cc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxoaXAlMjBob3AlMjBkYW5jZXxlbnwxfHx8fDE3NjA3MjgwNDB8MA&ixlib=rb-4.1.0&q=80&w=1080',
        'popular': true,
        'category': 'Современные',
        'rating': '4.9',
        'students': '124',
        'price': 800,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
        centerTitle: true,
      ),
      body: favoriteClasses.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Здесь пока ничего нет',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                   Text(
                    'Добавляйте занятия в избранное, чтобы они появились здесь',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: favoriteClasses.length,
              itemBuilder: (context, index) {
                final danceClass = favoriteClasses[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageWithFallback(
                          imageUrl: danceClass['image'] as String,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                danceClass['name'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                danceClass['instructor'] as String,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
