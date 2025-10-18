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

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int _selectedCategoryIndex = 0;
  String _searchQuery = '';
  String _selectedLevel = 'Все';
  RangeValues _priceRange = const RangeValues(0, 2000);
  bool _showOnlyPopular = false;

  final List<Map<String, dynamic>> _allDanceClasses = [
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
    {
      'id': '2',
      'name': 'Классический балет',
      'instructor': 'Елена Соколова',
      'level': 'Средний',
      'image': 'https://images.unsplash.com/photo-1495791185843-c73f2269f669?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxiYWxsZXQlMjBkYW5jZXJ8ZW58MXx8fHwxNzYwNzI4MDQwfDA&ixlib=rb-4.1.0&q=80&w=1080',
      'popular': false,
      'category': 'Классические',
      'rating': '4.8',
      'students': '89',
      'price': 1200,
    },
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
      'id': '4',
      'name': 'Современный джаз',
      'instructor': 'Мария Кузнецова',
      'level': 'Продвинутый',
      'image': 'https://images.unsplash.com/photo-1508700929628-666bc8bd84ea?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxqYXp6JTIwZGFuY2V8ZW58MXx8fHwxNzYwNzI4MDQwfDA&ixlib=rb-4.1.0&q=80&w=1080',
      'popular': false,
      'category': 'Современные',
      'rating': '4.7',
      'students': '67',
      'price': 1000,
    },
    {
      'id': '5',
      'name': 'Бачата для начинающих',
      'instructor': 'Диего Мартинес',
      'level': 'Начальный',
      'image': 'https://images.unsplash.com/photo-1547153760-18fc86324498?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxiYWNoYXRhJTIwZGFuY2V8ZW58MXx8fHwxNzYwNzI4MDQwfDA&ixlib=rb-4.1.0&q=80&w=1080',
      'popular': true,
      'category': 'Латина',
      'rating': '4.9',
      'students': '143',
      'price': 850,
    },
    {
      'id': '6',
      'name': 'Контемпорари',
      'instructor': 'Ольга Смирнова',
      'level': 'Средний',
      'image': 'https://images.unsplash.com/photo-1535525153412-5a42439a210d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjb250ZW1wb3JhcnklMjBkYW5jZXxlbnwxfHx8fDE3NjA3MjgwNDB8MA&ixlib=rb-4.1.0&q=80&w=1080',
      'popular': false,
      'category': 'Современные',
      'rating': '4.6',
      'students': '72',
      'price': 950,
    },
  ];

  final List<String> _categories = ['Все', 'Современные', 'Классические', 'Латина'];

  List<Map<String, dynamic>> get _filteredClasses {
    return _allDanceClasses.where((danceClass) {
      // Фильтр по категории
      bool categoryMatch = _selectedCategoryIndex == 0 || 
          danceClass['category'] == _categories[_selectedCategoryIndex];
      
      // Фильтр по поиску
      bool searchMatch = _searchQuery.isEmpty ||
          danceClass['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          danceClass['instructor'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      
      // Фильтр по уровню
      bool levelMatch = _selectedLevel == 'Все' || 
          danceClass['level'] == _selectedLevel;
      
      // Фильтр по цене
      bool priceMatch = danceClass['price'] >= _priceRange.start && 
          danceClass['price'] <= _priceRange.end;
      
      // Фильтр по популярности
      bool popularMatch = !_showOnlyPopular || danceClass['popular'] == true;
      
      return categoryMatch && searchMatch && levelMatch && priceMatch && popularMatch;
    }).toList();
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Фильтры',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setModalState(() {
                          _selectedLevel = 'Все';
                          _priceRange = const RangeValues(0, 2000);
                          _showOnlyPopular = false;
                        });
                        setState(() {
                          _selectedLevel = 'Все';
                          _priceRange = const RangeValues(0, 2000);
                          _showOnlyPopular = false;
                        });
                      },
                      child: const Text('Сбросить'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Уровень',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        children: ['Все', 'Начальный', 'Средний', 'Продвинутый']
                            .map((level) => FilterChip(
                                  label: Text(level),
                                  selected: _selectedLevel == level,
                                  onSelected: (selected) {
                                    setModalState(() {
                                      _selectedLevel = level;
                                    });
                                    setState(() {
                                      _selectedLevel = level;
                                    });
                                  },
                                  selectedColor: const Color(0xFF9B59B6),
                                  labelStyle: TextStyle(
                                    color: _selectedLevel == level
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Ценовой диапазон',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('₽${_priceRange.start.round()}'),
                          Text('₽${_priceRange.end.round()}'),
                        ],
                      ),
                      RangeSlider(
                        values: _priceRange,
                        min: 0,
                        max: 2000,
                        divisions: 20,
                        activeColor: const Color(0xFF9B59B6),
                        onChanged: (values) {
                          setModalState(() {
                            _priceRange = values;
                          });
                          setState(() {
                            _priceRange = values;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Только популярные',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                            value: _showOnlyPopular,
                            activeColor: const Color(0xFF9B59B6),
                            onChanged: (value) {
                              setModalState(() {
                                _showOnlyPopular = value;
                              });
                              setState(() {
                                _showOnlyPopular = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9B59B6),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Показать ${_filteredClasses.length} классов',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF9B59B6).withOpacity(0.1),
                      Colors.white,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Привет! 👋',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Найди свой стиль',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                        Container(
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
                          child: IconButton(
                            icon: const Icon(Icons.notifications_outlined),
                            color: const Color(0xFF9B59B6),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Найти танцевальный класс...',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                          suffixIcon: GestureDetector(
                            onTap: _showFilterDialog,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF9B59B6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.tune, color: Colors.white, size: 20),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Категории',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_filteredClasses.length} найдено',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
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
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedCategoryIndex == index;
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? const LinearGradient(
                                    colors: [Color(0xFF9B59B6), Color(0xFFD4A5E8)],
                                  )
                                : null,
                            color: isSelected ? null : Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? const Color(0xFF9B59B6).withOpacity(0.3)
                                    : Colors.black.withOpacity(0.05),
                                blurRadius: isSelected ? 12 : 8,
                                offset: Offset(0, isSelected ? 6 : 2),
                              ),
                            ],
                          ),
                          child: Text(
                            _categories[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            _filteredClasses.isEmpty
                ? SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(24),
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'Ничего не найдено',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Попробуйте изменить фильтры',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final danceClass = _filteredClasses[index];
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
                        childCount: _filteredClasses.length,
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
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                      stops: const [0.5, 1.0],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.darken,
                  child: ImageWithFallback(
                    imageUrl: danceClass['image'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (danceClass['popular'])
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6B9D), Color(0xFFC06C84)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF6B9D).withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.local_fire_department, color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          const Text(
                            'Популярно',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        danceClass['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.person_outline, color: Colors.white70, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            danceClass['instructor'],
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9B59B6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      danceClass['level'],
                      style: const TextStyle(
                        color: Color(0xFF9B59B6),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          danceClass['rating'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '₽${danceClass['price']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9B59B6),
                    ),
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