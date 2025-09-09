import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showTourId = false;

  @override
  Widget build(BuildContext context) {
    final Color scaffold = const Color(0xFFF4F5F7); // light bg like 2nd image
    final Color onBackground = const Color(0xFF111827); // near-black text
    final Color muted = const Color(0xFF6B7280); // gray text
    final Color card = Colors.white; // cards are white like 2nd image
    final Color accent = const Color(0xFF0EA5E9); // soft sky blue accents

    return Scaffold(
      backgroundColor: scaffold,
      bottomNavigationBar: _BottomNav(accent: accent, muted: muted, onBackground: onBackground),
      body: SafeArea(
        child: Column(
          children: [
            // Top header with SOS and Profile
            _TopHeader(onBackground: onBackground),
            
            // Main content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trip cards section
                    Row(
                      children: [
                        Expanded(
                          child: _CurrentTripCard(
                            card: card,
                            onBackground: onBackground,
                            muted: muted,
                            accent: accent,
                            showTourId: _showTourId,
                            onToggleTourId: () => setState(() => _showTourId = !_showTourId),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _YourTripsCard(
                            card: card,
                            onBackground: onBackground,
                            muted: muted,
                            accent: accent,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Quick Stats Section
                    _QuickStatsSection(card: card, onBackground: onBackground, muted: muted, accent: accent),
                    
                    const SizedBox(height: 20),
                    
                    // Mini Map section
                    _MiniMapCard(card: card, onBackground: onBackground, muted: muted),
                    
                    const SizedBox(height: 20),
                    
                    // Recent Activity Section
                    _RecentActivitySection(card: card, onBackground: onBackground, muted: muted, accent: accent),
                    
                    const SizedBox(height: 20),
                    
                    // Safety Tips Section
                    _SafetyTipsSection(card: card, onBackground: onBackground, muted: muted, accent: accent),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopHeader extends StatelessWidget {
  final Color onBackground;
  
  const _TopHeader({required this.onBackground});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SOS Button
          _SOSButton(),
          
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
            onTap: () {
              // Navigate to profile
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle SOS action
        _showSOSDialog(context);
      },
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
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Send SOS', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

class _CurrentTripCard extends StatelessWidget {
  final Color card;
  final Color onBackground;
  final Color muted;
  final Color accent;
  final bool showTourId;
  final VoidCallback onToggleTourId;

  const _CurrentTripCard({
    required this.card,
    required this.onBackground,
    required this.muted,
    required this.accent,
    required this.showTourId,
    required this.onToggleTourId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160, // Fixed height for equal sizing
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on_rounded, color: accent, size: 20),
              const SizedBox(width: 8),
              Text(
                'Current Trip',
                style: TextStyle(
                  color: onBackground,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Goa Beach Resort',
            style: TextStyle(
              color: onBackground,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Active • 2 days left',
            style: TextStyle(
              color: accent,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                'Tour ID: ',
                style: TextStyle(
                  color: muted,
                  fontSize: 14,
                ),
              ),
              Expanded(
                child: Text(
                  showTourId ? 'TRP-2024-001' : '••••••••••••',
                  style: TextStyle(
                    color: showTourId ? onBackground : muted,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onToggleTourId,
                child: Icon(
                  showTourId ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  color: accent,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _YourTripsCard extends StatelessWidget {
  final Color card;
  final Color onBackground;
  final Color muted;
  final Color accent;

  const _YourTripsCard({
    required this.card,
    required this.onBackground,
    required this.muted,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> trips = [
      {"name": "Iyer's House", "status": "Completed"},
      {"name": "Sikkim", "status": "Upcoming"},
      {"name": "PICT", "status": "Completed"},
    ];

    return Container(
      height: 160, // Fixed height to match Current Trip card
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.history_rounded, color: accent, size: 20),
              const SizedBox(width: 8),
              Text(
                'Your Trips',
                style: TextStyle(
                  color: onBackground,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Text(
                        '→ ',
                        style: TextStyle(
                          color: accent,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          trip['name']!,
                          style: TextStyle(
                            color: onBackground,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: trip['status'] == 'Completed' 
                              ? Colors.green.withOpacity(0.1)
                              : Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          trip['status']!,
                          style: TextStyle(
                            color: trip['status'] == 'Completed' 
                                ? Colors.green
                                : Colors.orange,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniMapCard extends StatelessWidget {
  final Color card;
  final Color onBackground;
  final Color muted;

  const _MiniMapCard({
    required this.card,
    required this.onBackground,
    required this.muted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'MINI MAP',
              style: TextStyle(
                color: onBackground,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1524661135-423995f22d0b?w=800&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withOpacity(0.1),
                ),
                child: const Center(
                  child: Icon(
                    Icons.location_on_rounded,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Quick Stats Section
class _QuickStatsSection extends StatelessWidget {
  final Color card;
  final Color onBackground;
  final Color muted;
  final Color accent;

  const _QuickStatsSection({
    required this.card,
    required this.onBackground,
    required this.muted,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Stats',
            style: TextStyle(
              color: onBackground,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  icon: Icons.trip_origin_rounded,
                  label: 'Total Trips',
                  value: '12',
                  color: accent,
                ),
              ),
              Expanded(
                child: _StatItem(
                  icon: Icons.location_on_rounded,
                  label: 'Cities Visited',
                  value: '8',
                  color: Colors.green,
                ),
              ),
              Expanded(
                child: _StatItem(
                  icon: Icons.security_rounded,
                  label: 'Safety Score',
                  value: '95%',
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF6B7280),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Recent Activity Section
class _RecentActivitySection extends StatelessWidget {
  final Color card;
  final Color onBackground;
  final Color muted;
  final Color accent;

  const _RecentActivitySection({
    required this.card,
    required this.onBackground,
    required this.muted,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: TextStyle(
                  color: onBackground,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  color: accent,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _ActivityItem(
            icon: Icons.check_circle_rounded,
            title: 'Trip Completed',
            subtitle: 'Goa Beach Resort',
            time: '2 hours ago',
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _ActivityItem(
            icon: Icons.location_on_rounded,
            title: 'Location Shared',
            subtitle: 'With family members',
            time: '5 hours ago',
            color: accent,
          ),
          const SizedBox(height: 12),
          _ActivityItem(
            icon: Icons.security_rounded,
            title: 'Safety Check',
            subtitle: 'All systems normal',
            time: '1 day ago',
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final Color color;

  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// Safety Tips Section
class _SafetyTipsSection extends StatelessWidget {
  final Color card;
  final Color onBackground;
  final Color muted;
  final Color accent;

  const _SafetyTipsSection({
    required this.card,
    required this.onBackground,
    required this.muted,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_rounded, color: Colors.amber, size: 20),
              const SizedBox(width: 8),
              Text(
                'Safety Tips',
                style: TextStyle(
                  color: onBackground,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SafetyTip(
            tip: 'Always share your location with trusted contacts',
            icon: Icons.share_location_rounded,
          ),
          const SizedBox(height: 12),
          _SafetyTip(
            tip: 'Keep emergency contacts updated',
            icon: Icons.contact_phone_rounded,
          ),
          const SizedBox(height: 12),
          _SafetyTip(
            tip: 'Check local safety guidelines before traveling',
            icon: Icons.info_rounded,
          ),
        ],
      ),
    );
  }
}

class _SafetyTip extends StatelessWidget {
  final String tip;
  final IconData icon;

  const _SafetyTip({
    required this.tip,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF0EA5E9).withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: const Color(0xFF0EA5E9), size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            tip,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomNav extends StatelessWidget {
  final Color accent;
  final Color muted;
  final Color onBackground;
  
  const _BottomNav({
    required this.accent,
    required this.muted,
    required this.onBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: accent,
        unselectedItemColor: muted,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_rounded),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emergency_rounded),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Alerts',
          ),
        ],
      ),
    );
  }
}