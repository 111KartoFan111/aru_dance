import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/welcome_screen.dart';

class DanceClassApp extends StatelessWidget {
  const DanceClassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dance Class Registration App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
