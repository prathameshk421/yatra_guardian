import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        brightness: Brightness.light,
        surface: AppColors.scaffold,
      ),
      scaffoldBackgroundColor: AppColors.scaffold,
      useMaterial3: true,
      fontFamily: 'Roboto',
      
      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.scaffold,
        elevation: 0,
        foregroundColor: AppColors.onBackground,
      ),
      
      // Bottom navigation bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.card,
        selectedItemColor: AppColors.onBackground,
        unselectedItemColor: AppColors.muted,
        showUnselectedLabels: false,
        elevation: 8,
      ),
      
      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
      ),
    );
  }
  
  static TextStyle get devanagariTitle => GoogleFonts.notoSansDevanagari(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.onBackground,
  );
  
  static TextStyle get englishTitle => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.onBackground,
  );
  
  static TextStyle get sectionHeader => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.onBackground,
  );
  
  static TextStyle get cardTitle => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.onBackground,
  );
  
  static TextStyle get mutedText => const TextStyle(
    color: AppColors.muted,
  );
  
  static TextStyle get whiteText => const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );
}
