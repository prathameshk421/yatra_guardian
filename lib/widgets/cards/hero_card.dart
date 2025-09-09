import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../constants/app_strings.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.hotels, style: AppTheme.cardTitle),
                const SizedBox(height: 8),
                Text(AppStrings.findGreatDeals, style: AppTheme.mutedText),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.accent.withOpacity(0.15),
              child: Icon(
                Icons.hotel_rounded,
                color: AppColors.accent,
                size: 36,
              ),
            ),
          )
        ],
      ),
    );
  }
}
