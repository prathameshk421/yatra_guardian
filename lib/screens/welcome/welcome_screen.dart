import 'package:flutter/material.dart';
import 'package:yatra_guardian/theme/app_theme.dart';
import 'package:yatra_guardian/widgets/common/language_dropdown.dart';
import 'package:yatra_guardian/widgets/common/social_button.dart';
import 'package:yatra_guardian/services/auth_service.dart';
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
                          'Welcome to  यात्रा  Guardian',
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
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Your trusted companion for safe and memorable journeys',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: AppTheme.mutedText.copyWith(
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ),

                      // Feature cards section
                      const SizedBox(height: 40),
                      Text(
                        'Navigate confidently with real-time safety alerts,\nconnect instantly with emergency services, and discover\npersonalized travel recommendations, all in one app',
                        textAlign: TextAlign.center,
                        style: AppTheme.mutedText.copyWith(
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Feature cards row
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Expanded(
                              child: _FeatureCard(
                                icon: Icons.security,
                                title: 'Safety First',
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: _FeatureCard(
                                icon: Icons.navigation,
                                title: 'Smart Navigation',
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: _FeatureCard(
                                icon: Icons.favorite,
                                title: 'Trusted Journeys',
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Push everything below to bottom
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
                        onPressed: () async {
                          try {
                            // Show loading indicator
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                            
                            // Authenticate with Google
                            final userProfile = await AuthService.authenticateWithGoogle();
                            
                            // Hide loading indicator
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                            
                            if (userProfile != null && context.mounted) {
                              // Navigate to home screen
                              Navigator.of(context).pushReplacementNamed('/home');
                            } else {
                              throw 'Failed to get user profile';
                            }
                          } catch (e) {
                            // Hide loading indicator if still showing
                            if (context.mounted) {
                              Navigator.of(context, rootNavigator: true).pop();
                              
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Google authentication failed: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      SocialButton(
                        label: 'Continue with Microsoft',
                        icon: Icons.apps,
                        height: buttonHeight,
                        leadingAsset: 'assets/icons/microsoft.svg',
                        leadingSize: 24,
                        onPressed: () async {
                          try {
                            // Show loading indicator
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                            
                            // Authenticate with Microsoft
                            final userProfile = await AuthService.authenticateWithMicrosoft();
                            
                            // Hide loading indicator
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                            
                            if (userProfile != null && context.mounted) {
                              // Navigate to home screen
                              Navigator.of(context).pushReplacementNamed('/home');
                            } else {
                              throw 'Failed to get user profile';
                            }
                          } catch (e) {
                            // Hide loading indicator if still showing
                            if (context.mounted) {
                              Navigator.of(context, rootNavigator: true).pop();
                              
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Microsoft authentication failed: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
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

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FeatureCard({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 28,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
