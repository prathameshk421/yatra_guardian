import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../constants/app_strings.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: AppStrings.devanagariPart,
                    style: AppTheme.devanagariTitle,
                  ),
                  TextSpan(
                    text: AppStrings.englishPart,
                    style: AppTheme.englishTitle,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Icon(
              Icons.notifications_none_rounded,
              color: AppColors.onBackground,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
