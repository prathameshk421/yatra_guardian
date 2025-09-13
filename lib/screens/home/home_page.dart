import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/common/top_header_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Color scaffold = const Color(0xFFF4F5F7); // light bg like 2nd image
    final Color onBackground = const Color(0xFF111827); // near-black text
    final Color muted = const Color(0xFF6B7280); // gray text
    final Color card = Colors.white; // cards are white like 2nd image
    final Color accent = const Color(0xFF0EA5E9); // soft sky blue accents

    return Scaffold(
      backgroundColor: scaffold,
      body: SafeArea(
        child: Column(
          children: [
            TopHeaderWidget(onBackground: onBackground),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _QuickStatsCard(
                            card: card,
                            onBackground: onBackground,
                            muted: muted,
                            accent: accent,
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
                    _CurrentTripSection(card: card, onBackground: onBackground, muted: muted, accent: accent),
                    const SizedBox(height: 20),
                    _MiniMapCard(card: card, onBackground: onBackground, muted: muted),
                    const SizedBox(height: 20),
                    _RecentActivitySection(card: card, onBackground: onBackground, muted: muted, accent: accent),
                    const SizedBox(height: 20),
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

class _QuickStatsCard extends StatelessWidget {
  final Color card;
  final Color onBackground;
  final Color muted;
  final Color accent;

  const _QuickStatsCard({
    required this.card,
    required this.onBackground,
    required this.muted,
    required this.accent,
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
              Icon(Icons.analytics_rounded, color: accent, size: 20),
              const SizedBox(width: 8),
              Text(
                'Quick Stats',
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.trip_origin_rounded, color: accent, size: 16),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Total Trips: 12',
                        style: TextStyle(
                          color: onBackground,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.location_on_rounded, color: Colors.green, size: 16),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Cities Visited: 8',
                        style: TextStyle(
                          color: onBackground,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrentTripSection extends StatelessWidget {
  final Color card;
  final Color onBackground;
  final Color muted;
  final Color accent;

  const _CurrentTripSection({
    required this.card,
    required this.onBackground,
    required this.muted,
    required this.accent,
  });

  void _copyTripIdToClipboard(BuildContext context) {
    const tripId = 'trip_1757437199588_bpdolvdr6';
    Clipboard.setData(const ClipboardData(text: tripId));
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            const Text('Trip ID copied to clipboard!'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

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
              Icon(Icons.location_on_rounded, color: accent, size: 20),
              const SizedBox(width: 8),
              Text(
                'Current Trip',
                style: TextStyle(
                  color: onBackground,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400&q=80'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Goa Beach Resort',
                      style: TextStyle(
                        color: onBackground,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Active • 2 days left',
                      style: TextStyle(
                        color: accent,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.security_rounded, color: Colors.green, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                'Safety: 95%',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Tour ID: ',
                          style: TextStyle(
                            color: muted,
                            fontSize: 14,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '••••••••••••••••••••••••••••••',
                            style: TextStyle(
                              color: muted,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _copyTripIdToClipboard(context),
                          child: Icon(
                            Icons.copy_rounded,
                            color: accent,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
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
      {"name": "Mumbai Gateway", "status": "Completed"},
      {"name": "Kerala Backwaters", "status": "Upcoming"},
      {"name": "Rajasthan Desert", "status": "Completed"},
      {"name": "Himachal Hills", "status": "Upcoming"},
      {"name": "Chennai Marina", "status": "Completed"},
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
            child: SingleChildScrollView(
              child: Column(
                children: trips.map((trip) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            trip['name']!,
                            style: TextStyle(
                              color: onBackground,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          trip['status'] == 'Completed' 
                              ? Icons.check_circle_rounded
                              : Icons.schedule_rounded,
                          color: trip['status'] == 'Completed' 
                              ? Colors.green
                              : Colors.orange,
                          size: 16,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
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