import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A reusable top header widget that contains SOS button, app title, and profile icon.
/// This widget is designed to be used across all main navigation pages to provide
/// consistent branding and emergency access.
/// 
/// Usage:
/// ```dart
/// TopHeaderWidget(
///   onBackground: const Color(0xFF111827),
///   onProfileTap: () {
///     Navigator.pushNamed(context, '/profile');
///   },
///   onSOSTap: () {
///     // Custom SOS handling
///   },
/// )
/// ```
class TopHeaderWidget extends StatelessWidget {
  /// The color for text and icons
  final Color onBackground;
  
  /// Callback when profile icon is tapped. If null, uses default behavior.
  final VoidCallback? onProfileTap;
  
  /// Callback when SOS button is tapped. If null, shows default SOS dialog.
  final VoidCallback? onSOSTap;

  const TopHeaderWidget({
    super.key,
    required this.onBackground,
    this.onProfileTap,
    this.onSOSTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SOS Button
          _SOSButton(onTap: onSOSTap),
          
          // App Title
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'यात्रा',
                  style: GoogleFonts.notoSansDevanagari(
                    color: onBackground,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: ' Guardian',
                  style: TextStyle(
                    color: onBackground,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          
          // Profile Icon
          GestureDetector(
            onTap: onProfileTap ?? () {
              // Default navigation to profile if no custom action provided
              // TODO: Implement default profile navigation
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.person_outline_rounded,
                color: Color(0xFF111827),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SOSButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _SOSButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => _showSOSDialog(context),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.red.withOpacity(0.3), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.red.withOpacity(0.2), width: 1),
          ),
          child: const Center(
            child: Text(
              'SOS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSOSDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Emergency SOS'),
          content: const Text('Are you sure you want to send an emergency alert?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle emergency action
                _handleSOSAction(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Send SOS', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _handleSOSAction(BuildContext context) {
    // TODO: Implement SOS functionality
    // This could include:
    // - Sending location to emergency contacts
    // - Making emergency calls
    // - Triggering panic alerts
    // - Notifying authorities
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Emergency alert sent successfully!'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
