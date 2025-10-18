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
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
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
    );
  }

  Widget _buildNavItem(BuildContext context, {required String iconPath, required String label, required String screenName}) {
    final bool isActive = activeScreen == screenName;
    final Color color = isActive ? const Color(0xFF9B59B6) : Colors.grey;

    return InkWell(
      onTap: () => onNavigate(screenName),
      borderRadius: BorderRadius.circular(30),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              height: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(color: color, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
