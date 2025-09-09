import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_bottom_nav_bar.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/cards/hero_card.dart';
import '../../widgets/cards/category_pill.dart';
import '../../widgets/cards/coupon_banner.dart';
import '../../widgets/cards/promo_card.dart';
import '../../widgets/cards/small_promo_card.dart';
import '../../widgets/cards/vip_status_card.dart';
import 'widgets/top_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      bottomNavigationBar: const CustomBottomNavBar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: CustomAppBar(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 44,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  children: const [
                    TopTab(
                      label: AppStrings.stays,
                      icon: Icons.bed_rounded,
                      selected: true,
                    ),
                    TopTab(
                      label: AppStrings.carRental,
                      icon: Icons.directions_car_rounded,
                      selected: false,
                    ),
                    TopTab(
                      label: AppStrings.taxi,
                      icon: Icons.local_taxi_rounded,
                      selected: false,
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: HeroCard(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: CategoryPill(
                        title: AppStrings.flights,
                        icon: Icons.flight_takeoff_rounded,
                        color: AppColors.lightBlue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CategoryPill(
                        title: AppStrings.activities,
                        icon: Icons.emoji_events_rounded,
                        color: AppColors.lightPink,
                        badgeText: AppStrings.newBadge,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CategoryPill(
                        title: AppStrings.homesApts,
                        icon: Icons.holiday_village_rounded,
                        color: AppColors.lightOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CouponBanner(),
              ),
            ),
            const SliverToBoxAdapter(
              child: SectionHeader(title: AppStrings.promotions),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 160,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => const PromoCard(
                    title: AppStrings.travelDeals,
                    imageUrl: 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=800&q=80',
                  ),
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemCount: 2,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: VipStatusCard(),
              ),
            ),
            const SliverToBoxAdapter(
              child: SectionHeader(title: AppStrings.exploreTheWorld),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                child: Row(
                  children: const [
                    Expanded(
                      child: SmallPromoCard(
                        title: AppStrings.explore,
                        imageUrl: 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=800&q=80',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: SmallPromoCard(
                        title: AppStrings.explore,
                        imageUrl: 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=800&q=80',
                      ),
                    ),
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
