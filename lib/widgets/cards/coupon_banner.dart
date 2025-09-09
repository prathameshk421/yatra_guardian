import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../constants/app_strings.dart';

class CouponBanner extends StatelessWidget {
  const CouponBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
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
          Icon(Icons.local_offer_outlined, color: AppColors.accent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              AppStrings.couponText,
              style: const TextStyle(
                color: AppColors.onBackground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: AppColors.accent.withOpacity(0.1),
              foregroundColor: AppColors.accent,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            child: const Text(AppStrings.claim),
          )
        ],
      ),
    );
  }
}
