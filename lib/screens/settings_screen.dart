import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _darkMode = false;
  String _selectedLanguage = 'Русский';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Аккаунт'),
          _buildTile(
            icon: Icons.person_outline,
            title: 'Профиль',
            subtitle: 'Личная информация',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Открыт профиль')),
              );
            },
          ),
          _buildTile(
            icon: Icons.lock_outline,
            title: 'Безопасность',
            subtitle: 'Пароль и аутентификация',
            onTap: () {
              _showSecurityDialog();
            },
          ),
          _buildTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Конфиденциальность',
            subtitle: 'Управление данными',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Настройки конфиденциальности')),
              );
            },
          ),
          _buildSectionHeader('Уведомления'),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: const Text('Push-уведомления'),
            subtitle: const Text('О новых занятиях и событиях'),
            value: _pushNotifications,
            activeColor: const Color(0xFF9B59B6),
            onChanged: (bool value) {
              setState(() {
                _pushNotifications = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    value
                        ? 'Push-уведомления включены'
                        : 'Push-уведомления выключены',
                  ),
                ),
              );
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.email_outlined),
            title: const Text('Email уведомления'),
            subtitle: const Text('Новости и специальные предложения'),
            value: _emailNotifications,
            activeColor: const Color(0xFF9B59B6),
            onChanged: (bool value) {
              setState(() {
                _emailNotifications = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    value
                        ? 'Email уведомления включены'
                        : 'Email уведомления выключены',
                  ),
                ),
              );
            },
          ),
          _buildSectionHeader('Внешний вид'),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode_outlined),
            title: const Text('Темная тема'),
            subtitle: const Text('Включить темный режим'),
            value: _darkMode,
            activeColor: const Color(0xFF9B59B6),
            onChanged: (bool value) {
              setState(() {
                _darkMode = value;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    value ? 'Темная тема включена' : 'Светлая тема включена',
                  ),
                ),
              );
            },
          ),
          _buildTile(
            icon: Icons.language,
            title: 'Язык',
            subtitle: _selectedLanguage,
            onTap: () {
              _showLanguageDialog();
            },
          ),
          _buildSectionHeader('Другое'),
          _buildTile(
            icon: Icons.help_outline,
            title: 'Помощь и поддержка',
            subtitle: 'FAQ и обратная связь',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Центр поддержки')),
              );
            },
          ),
          _buildTile(
            icon: Icons.info_outline,
            title: 'О приложении',
            subtitle: 'Версия 1.0.0',
            onTap: () {
              _showAboutDialog();
            },
          ),
          _buildTile(
            icon: Icons.description_outlined,
            title: 'Условия использования',
            subtitle: 'Правила и политика',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Условия использования')),
              );
            },
          ),
          _buildTile(
            icon: Icons.star_outline,
            title: 'Оценить приложение',
            subtitle: 'Поделитесь вашим мнением',
            onTap: () {
              _showRatingDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF9B59B6),
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выберите язык'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Русский'),
                value: 'Русский',
                groupValue: _selectedLanguage,
                activeColor: const Color(0xFF9B59B6),
                onChanged: (String? value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Язык изменен на $value')),
                  );
                },
              ),
              RadioListTile<String>(
                title: const Text('English'),
                value: 'English',
                groupValue: _selectedLanguage,
                activeColor: const Color(0xFF9B59B6),
                onChanged: (String? value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Language changed to $value')),
                  );
                },
              ),
              RadioListTile<String>(
                title: const Text('Қазақша'),
                value: 'Қазақша',
                groupValue: _selectedLanguage,
                activeColor: const Color(0xFF9B59B6),
                onChanged: (String? value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Тіл $value-ға өзгертілді')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSecurityDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Безопасность'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.lock_reset, color: Color(0xFF9B59B6)),
                title: const Text('Изменить пароль'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Открыта форма смены пароля')),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.fingerprint, color: Color(0xFF9B59B6)),
                title: const Text('Биометрия'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Настройка биометрии')),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.security, color: Color(0xFF9B59B6)),
                title: const Text('Двухфакторная аутентификация'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Настройка 2FA')),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('О приложении'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'VIBE Dance Studio',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9B59B6),
                ),
              ),
              const SizedBox(height: 8),
              const Text('Версия 1.0.0'),
              const SizedBox(height: 16),
              Text(
                'Приложение для записи на танцевальные классы',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              const Text('© 2024 VIBE Dance Studio'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  void _showRatingDialog() {
    int rating = 0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Оцените приложение'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Ваше мнение важно для нас!'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 32,
                        ),
                        onPressed: () {
                          setDialogState(() {
                            rating = index + 1;
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Отмена'),
                ),
                ElevatedButton(
                  onPressed: rating > 0
                      ? () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Спасибо за оценку $rating звезд!'),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9B59B6),
                  ),
                  child: const Text('Отправить', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}