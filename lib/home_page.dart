import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color scaffold = const Color(0xFFF4F5F7);
    final Color onBackground = const Color(0xFF111827);
    final Color muted = const Color(0xFF6B7280);
    final Color card = Colors.white;
    final Color accent = const Color(0xFF0EA5E9);

    return Scaffold(
      backgroundColor: scaffold,
      bottomNavigationBar: _BottomNav(accent: accent, muted: muted, onBackground: onBackground),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
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
                    const Spacer(),
                    Icon(Icons.notifications_none_rounded, color: onBackground),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 44,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _TopTab(label: 'Stays', icon: Icons.bed_rounded, selected: true, accent: accent, onBackground: onBackground, muted: muted),
                    _TopTab(label: 'Car rental', icon: Icons.directions_car_rounded, selected: false, accent: accent, onBackground: onBackground, muted: muted),
                    _TopTab(label: 'Taxi', icon: Icons.local_taxi_rounded, selected: false, accent: accent, onBackground: onBackground, muted: muted),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _HeroCard(card: card, accent: accent, onBackground: onBackground, muted: muted),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(child: _CategoryPill(title: 'Flights', icon: Icons.flight_takeoff_rounded, color: Colors.lightBlue.shade100, textColor: onBackground)),
                    const SizedBox(width: 12),
                    Expanded(child: _CategoryPill(title: 'Activities', icon: Icons.emoji_events_rounded, color: Colors.pink.shade100, textColor: onBackground, badgeText: 'New!')),
                    const SizedBox(width: 12),
                    Expanded(child: _CategoryPill(title: 'Homes &\nApts', icon: Icons.holiday_village_rounded, color: Colors.orange.shade100, textColor: onBackground)),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _CouponBanner(card: card, accent: accent, muted: muted, onBackground: onBackground),
              ),
            ),
            _SectionHeader(title: 'Promotions', color: onBackground),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 160,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => _ImagePromoCard(card: card),
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemCount: 2,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _VipStatusCard(card: card, muted: muted, onBackground: onBackground),
              ),
            ),
            _SectionHeader(title: 'Explore the World', color: onBackground),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                child: Row(
                  children: [
                    Expanded(child: _SmallPromoCard(card: card)),
                    const SizedBox(width: 12),
                    Expanded(child: _SmallPromoCard(card: card)),
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

class _TopTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Color accent;
  final Color onBackground;
  final Color muted;

  const _TopTab({
    required this.label,
    required this.icon,
    required this.selected,
    required this.accent,
    required this.onBackground,
    required this.muted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: selected ? accent : Colors.transparent, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: selected ? accent : muted),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? onBackground : muted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final Color card;
  final Color accent;
  final Color onBackground;
  final Color muted;
  const _HeroCard({required this.card, required this.accent, required this.onBackground, required this.muted});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hotels', style: TextStyle(color: onBackground, fontSize: 24, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text('Find great deals near you', style: TextStyle(color: muted)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 36,
              backgroundColor: accent.withOpacity(0.15),
              child: Icon(Icons.hotel_rounded, color: accent, size: 36),
            ),
          )
        ],
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Color textColor;
  final String? badgeText;
  const _CategoryPill({required this.title, required this.icon, required this.color, required this.textColor, this.badgeText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(backgroundColor: Colors.white, child: Icon(icon, color: textColor)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          if (badgeText != null)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(8)),
                child: Text(badgeText!, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
              ),
            ),
        ],
      ),
    );
  }
}

class _CouponBanner extends StatelessWidget {
  final Color card;
  final Color accent;
  final Color muted;
  final Color onBackground;
  const _CouponBanner({required this.card, required this.accent, required this.muted, required this.onBackground});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Icon(Icons.local_offer_outlined, color: accent),
          const SizedBox(width: 8),
          Expanded(
            child: Text('10% off coupon for 1st App Booking', style: TextStyle(color: onBackground, fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(backgroundColor: accent.withOpacity(0.1), foregroundColor: accent, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6)),
            child: const Text('Claim'),
          )
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color color;
  const _SectionHeader({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
        child: Text(title, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w800)),
      ),
    );
  }
}

class _ImagePromoCard extends StatelessWidget {
  final Color card;
  const _ImagePromoCard({required this.card});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=800&q=80'),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.45),
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
          ),
          padding: const EdgeInsets.all(12),
          child: const Text('Travel Deals', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}

class _VipStatusCard extends StatelessWidget {
  final Color card;
  final Color muted;
  final Color onBackground;
  const _VipStatusCard({required this.card, required this.muted, required this.onBackground});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('VIP Status', style: TextStyle(color: onBackground, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text('As a VIP Bronze member receive a larger discount.', style: TextStyle(color: muted)),
              ],
            ),
          ),
          const CircleAvatar(
            backgroundColor: Color(0xFFFFF1C2),
            child: Icon(Icons.monetization_on_rounded, color: Color(0xFFF59E0B)),
          )
        ],
      ),
    );
  }
}

class _SmallPromoCard extends StatelessWidget {
  final Color card;
  const _SmallPromoCard({required this.card});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=800&q=80'),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.55), borderRadius: BorderRadius.circular(8)),
            child: const Text('Explore', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final Color accent;
  final Color muted;
  final Color onBackground;
  const _BottomNav({required this.accent, required this.muted, required this.onBackground});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: onBackground,
        unselectedItemColor: muted,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_rounded), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}


