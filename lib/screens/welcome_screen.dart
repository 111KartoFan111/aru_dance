import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFF9B59B6),
              Color(0xFFD4A5E8),
              Color(0xFFF8B4D9),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _buildHeader(context),
              const Spacer(),
              _buildFeatures(context),
              const Spacer(),
              _buildStartButton(context),
              const Padding(
                padding: EdgeInsets.only(bottom: 32.0),
                child: Text(
                  'Присоединяйся к сообществу танцоров',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SvgPicture.asset(
            'assets/images/music.svg',
            height: 48,
            width: 48,
            colorFilter: const ColorFilter.mode(Color(0xFF9B59B6), BlendMode.srcIn),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'DanceFlow',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Начни танцевать уже сегодня',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatures(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          _buildFeatureCard(
            context,
            icon: 'assets/images/music.svg',
            title: 'Разнообразие стилей',
            description: 'Хип-хоп, балет, сальса и многое другое',
          ),
          const SizedBox(height: 16),
          _buildFeatureCard(
            context,
            icon: 'assets/images/users.svg',
            title: 'Опытные инструкторы',
            description: 'Профессионалы с многолетним опытом',
          ),
          const SizedBox(height: 16),
          _buildFeatureCard(
            context,
            icon: 'assets/images/sparkles.svg',
            title: 'Удобная запись',
            description: 'Бронируйте занятия в несколько кликов',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, {required String icon, required String title, required String description}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              icon,
              height: 20,
              width: 20,
              colorFilter: const ColorFilter.mode(Color(0xFF9B59B6), BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 5,
          ),
          child: const Text(
            'Начать',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9B59B6),
            ),
          ),
        ),
      ),
    );
  }
}
