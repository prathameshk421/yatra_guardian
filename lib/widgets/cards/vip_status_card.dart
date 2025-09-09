import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../constants/app_strings.dart';

class VipStatusCard extends StatelessWidget {
  const VipStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.vipStatus,
                  style: const TextStyle(
                    color: AppColors.onBackground,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  AppStrings.vipDescription,
                  style: const TextStyle(color: AppColors.muted),
                ),
              ],
            ),
          ),
          const CircleAvatar(
            backgroundColor: AppColors.goldLight,
            child: Icon(
              Icons.monetization_on_rounded,
              color: AppColors.gold,
            ),
          )
        ],
      ),
    );
  }
}
