import 'package:flutter/material.dart';
import 'package:yatra_guardian/screens/home/home_page.dart';
import 'package:yatra_guardian/screens/trip/create_trip_page.dart';
import 'package:yatra_guardian/screens/emergency/emergency_page.dart';
import 'package:yatra_guardian/widgets/common/bottom_navigation_widget.dart';
import 'package:yatra_guardian/widgets/common/top_header_widget.dart';

class MainLayout extends StatefulWidget {
  final int initialIndex;

  const MainLayout({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          const HomePage(),
          _ExplorePage(),
          const CreateTripPage(),
          const EmergencyPage(),
          _AlertsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

// Placeholder pages - replace with your actual pages
class _ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color scaffold = const Color(0xFFF4F5F7);
    final Color onBackground = const Color(0xFF111827);
    
    return Scaffold(
      backgroundColor: scaffold,
      body: SafeArea(
        child: Column(
          children: [
            // Top header with SOS and Profile
            TopHeaderWidget(onBackground: onBackground),
            
            // Main content
            Expanded(
              child: Center(
                child: Text(
                  'Explore Page',
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold,
                    color: onBackground,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _AlertsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color scaffold = const Color(0xFFF4F5F7);
    final Color onBackground = const Color(0xFF111827);
    
    return Scaffold(
      backgroundColor: scaffold,
      body: SafeArea(
        child: Column(
          children: [
            // Top header with SOS and Profile
            TopHeaderWidget(onBackground: onBackground),
            
            // Main content
            Expanded(
              child: Center(
                child: Text(
                  'Alerts Page',
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold,
                    color: onBackground,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
