import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class CategoryPill extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String? badgeText;

  const CategoryPill({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(icon, color: AppColors.onBackground),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.onBackground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (badgeText != null)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badgeText!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
