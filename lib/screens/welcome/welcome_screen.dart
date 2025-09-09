import 'package:flutter/material.dart';
import 'package:yatra_guardian/theme/app_theme.dart';
import 'package:yatra_guardian/widgets/common/language_dropdown.dart';
import 'package:yatra_guardian/widgets/common/social_button.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final isSmallHeight = size.height < 700;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final contentWidth = constraints.maxWidth;
            final maxContent = contentWidth > 600 ? 480.0 : contentWidth;
            final buttonHeight = contentWidth > 600 ? 56.0 : 54.0;
            final radius = contentWidth > 600 ? 56.0 : 52.0;

            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxContent),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: isSmallHeight ? 8 : 20),
                      // Logo at top-center (reference-aligned)
                      Container(
                        width: radius * 2,
                        height: radius * 2,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(Icons.place, size: 44, color: Colors.black),
                      ),
                      const SizedBox(height: 18),
                      // Title (single line, scales down if needed)
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Welcome to Yatra Guardian',
                          maxLines: 1,
                          softWrap: false,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Subtitle/tagline under title
                      Text(
                        'Your trusted companion for safe and memorable journeys',
                        textAlign: TextAlign.center,
                        style: AppTheme.mutedText.copyWith(
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),

                      // Leave breathable space in the middle for a future background image
                      const Spacer(),

                      // Language selector
                      const LanguageDropdown(
                        initialValue: 'English (US)',
                        options: <String>['English (US)', 'हिन्दी', 'বাংলা', 'తెలుగు', 'मराठी'],
                      ),

                      const SizedBox(height: 20),
                      // Social buttons near bottom like reference
                      SocialButton(
                        label: 'Continue with Google',
                        icon: Icons.public,
                        height: buttonHeight,
                        leadingAsset: 'assets/icons/google.svg',
                        leadingSize: 24,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 12),
                      SocialButton(
                        label: 'Continue with Microsoft',
                        icon: Icons.apps,
                        height: buttonHeight,
                        leadingAsset: 'assets/icons/microsoft.svg',
                        leadingSize: 24,
                        onPressed: () {},
                      ),

                      SizedBox(height: isSmallHeight ? 12 : 16),
                      // Footer
                      Text(
                        'By continuing, you agree to our Terms & Privacy Policy',
                        textAlign: TextAlign.center,
                        style: AppTheme.mutedText.copyWith(fontSize: 12),
                      ),
                      SizedBox(height: isSmallHeight ? 4 : 8),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
