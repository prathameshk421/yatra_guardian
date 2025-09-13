import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final double height;
  final String? leadingAsset;
  final double leadingSize;

  const SocialButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.height = 54,
    this.leadingAsset,
    this.leadingSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final radius = width > 600 ? 16.0 : 14.0;
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 6,
          shadowColor: Colors.black.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (leadingAsset != null)
              leadingAsset!.endsWith('.svg')
                  ? SvgPicture.asset(
                      leadingAsset!,
                      width: leadingSize,
                      height: leadingSize,
                      fit: BoxFit.contain,
                    )
                  : Image.asset(
                      leadingAsset!,
                      width: leadingSize,
                      height: leadingSize,
                      fit: BoxFit.contain,
                      errorBuilder: (context, _, __) => Icon(icon, color: Colors.white, size: leadingSize),
                    )
            else
              Icon(icon, color: Colors.white, size: leadingSize),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
