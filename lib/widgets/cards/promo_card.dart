import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';

class PromoCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double? width;
  final double height;

  const PromoCard({
    super.key,
    required this.title,
    required this.imageUrl,
    this.width,
    this.height = 160,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 220,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.45),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Text(title, style: AppTheme.whiteText),
        ),
      ),
    );
  }
}
