import 'package:flutter/material.dart';
import 'package:yatra_guardian/screens/home/home_page.dart';
import 'theme/app_theme.dart';
import 'screens/welcome/welcome_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'यात्रा Guardian',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
