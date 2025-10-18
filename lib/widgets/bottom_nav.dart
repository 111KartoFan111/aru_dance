import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNav extends StatelessWidget {
  final String activeScreen;
  final Function(String) onNavigate;

  const BottomNav({
    super.key,
    required this.activeScreen,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(
                context,
                iconPath: 'assets/images/home.svg',
                label: 'Главная',
                screenName: 'home',
              ),
              _buildNavItem(
                context,
                iconPath: 'assets/images/calendar.svg',
                label: 'Расписание',
                screenName: 'schedule',
              ),
              _buildNavItem(
                context,
                iconPath: 'assets/images/user.svg',
                label: 'Профиль',
                screenName: 'profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, {required String iconPath, required String label, required String screenName}) {
    final bool isActive = activeScreen == screenName;

    return Expanded(
      child: GestureDetector(
        onTap: () => onNavigate(screenName),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            gradient: isActive
                ? const LinearGradient(
                    colors: [Color(0xFF9B59B6), Color(0xFFD4A5E8)],
                  )
                : null,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(
                  isActive ? Colors.white : Colors.grey,
                  BlendMode.srcIn,
                ),
                height: 24,
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey,
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}