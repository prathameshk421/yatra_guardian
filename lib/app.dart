import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/welcome/welcome_screen.dart';
import 'package:yatra_guardian/screens/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yatra Guardian',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
  home: HomePage(),
    );
  }
}
