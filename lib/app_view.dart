import 'package:flutter/material.dart';
import 'package:giventake/screens/auth/views/welcome_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recycle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: const ColorScheme.light(
          background: Color(0xFFF7F7F7),
          onBackground: Color(0xFF818181),
          primary: Color(0xFF6C8A47),
          onPrimary: Colors.white,
          secondary: Color(0xFF97BE78),
          onSecondary: Colors.white,
          tertiary: Color(0xFFECEAEB),
          onTertiary: Color(0xFF818181),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
