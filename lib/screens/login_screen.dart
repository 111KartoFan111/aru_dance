import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Добро пожаловать',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Войдите или создайте аккаунт для продолжения',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 40),
                _buildTabs(),
                const SizedBox(height: 20),
                _buildTabViews(),
                const SizedBox(height: 30),
                _buildSocialLoginDivider(),
                const SizedBox(height: 20),
                _buildSocialButtons(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        labelColor: const Color(0xFF9B59B6),
        unselectedLabelColor: Colors.black54,
        tabs: const [
          Tab(text: 'Вход'),
          Tab(text: 'Регистрация'),
        ],
      ),
    );
  }

  Widget _buildTabViews() {
    return SizedBox(
      height: 350,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildLoginForm(),
          _buildRegisterForm(),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        _buildTextField(label: 'Email', hint: 'your@email.com'),
        const SizedBox(height: 20),
        _buildTextField(label: 'Пароль', hint: '••••••••', obscureText: true),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Забыли пароль?',
              style: TextStyle(color: Color(0xFF9B59B6)),
            ),
          ),
        ),
        const Spacer(),
        _buildAuthButton(label: 'Войти'),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Column(
      children: [
        _buildTextField(label: 'Имя', hint: 'Ваше имя'),
        const SizedBox(height: 20),
        _buildTextField(label: 'Email', hint: 'your@email.com'),
        const SizedBox(height: 20),
        _buildTextField(label: 'Пароль', hint: '••••••••', obscureText: true),
        const Spacer(),
        _buildAuthButton(label: 'Создать аккаунт'),
      ],
    );
  }

  Widget _buildTextField({required String label, required String hint, bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildAuthButton({required String label}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
           Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (Route<dynamic> route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9B59B6),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSocialLoginDivider() {
    return const Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Или продолжить с', style: TextStyle(color: Colors.black54)),
        ),
        Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Column(
      children: [
        _buildSocialButton(iconPath: 'assets/images/google.svg', label: 'Google'),
        const SizedBox(height: 16),
        _buildSocialButton(iconPath: 'assets/images/apple.svg', label: 'Apple'),
      ],
    );
  }

  Widget _buildSocialButton({required String iconPath, required String label}) {
     return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
           Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (Route<dynamic> route) => false,
          );
        },
        icon: SvgPicture.asset(iconPath, height: 24, width: 24),
        label: Text(label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(color: Colors.grey[300]!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
