
import 'package:flutter/material.dart';
import 'Welcome_screen.dart';

void main() {
  runApp(const MediKioskApp());
}

class MediKioskApp extends StatelessWidget {
  const MediKioskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediKiosk',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),

        scaffoldBackgroundColor: const Color(0xFFF7F9FA),

        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),

      home: const WelcomeScreen(),
    );
  }
}