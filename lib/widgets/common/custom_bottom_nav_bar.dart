import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../constants/app_strings.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.onBackground,
        unselectedItemColor: AppColors.muted,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded),
            label: AppStrings.map,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded),
            label: AppStrings.favorites,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: AppStrings.profile,
          ),
        ],
      ),
    );
  }
}
