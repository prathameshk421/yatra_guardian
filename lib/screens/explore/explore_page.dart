import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/common/top_header_widget.dart';
import '../../theme/app_colors.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<PlaceData> _places = [
    PlaceData(
      title: 'Red Fort',
      description: 'Historic Mughal fortress and UNESCO World Heritage Site in Delhi',
      imageUrl: 'https://images.unsplash.com/photo-1705524220998-4b4b51bd12f6?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cmVkJTIwZm9ydHxlbnwwfDF8MHx8fDI%3D',
      latitude: 28.6562,
      longitude: 77.2410,
    ),
    PlaceData(
      title: 'Gateway of India',
      description: 'Iconic arch monument overlooking the Arabian Sea in Mumbai',
      imageUrl: 'https://images.unsplash.com/photo-1598434192043-71111c1b3f41?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Z2F0ZXdheSUyMG9mJTIwaW5kaWF8ZW58MHwxfDB8fHwy',
      latitude: 18.9220,
      longitude: 72.8347,
    ),
    PlaceData(
      title: 'Mysore Palace',
      description: 'Royal palace known for its Indo-Saracenic architecture',
      imageUrl: 'https://images.unsplash.com/photo-1647250945832-5b5aa0f6366e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bXlzb3JlJTIwcGFsYWNlfGVufDB8MXwwfHx8Mg%3D%3D',
      latitude: 12.3051,
      longitude: 76.6551,
    ),
    PlaceData(
      title: 'Golden Temple',
      description: 'Sacred Sikh gurdwara covered in gold in Amritsar',
      imageUrl: 'https://images.unsplash.com/photo-1623059508779-2542c6e83753?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Z29sZGVuJTIwdGVtcGxlfGVufDB8MXwwfHx8Mg%3D%3D',
      latitude: 31.6200,
      longitude: 74.8765,
    ),
    PlaceData(
      title: 'Backwaters of Kerala',
      description: 'Serene network of lagoons and lakes in Alleppey',
      imageUrl: 'https://images.unsplash.com/photo-1722838012726-92be624f4d2b?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmFja3dhdHJlcyUyMG9mJTIwa2VyYWxhfGVufDB8MXwwfHx8Mg%3D%3D',
      latitude: 9.4981,
      longitude: 76.3388,
    ),
    PlaceData(
      title: 'Taj Mahal',
      description: 'Iconic white marble mausoleum and UNESCO World Heritage Site in Agra',
      imageUrl: 'https://images.unsplash.com/photo-1526711657229-e7e080ed7aa1?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dGFqJTIwbWFoYWx8ZW58MHwxfDB8fHwy',
      latitude: 27.1751,
      longitude: 78.0421,
    ),
  ];

  Future<void> _openInGoogleMaps(double latitude, double longitude, String placeName) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&query_place_id=$placeName';
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not open Google Maps'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening maps: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SafeArea(
        child: Column(
          children: [
            TopHeaderWidget(onBackground: AppColors.onBackground),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Explore Places',
                    style: TextStyle(
                      color: AppColors.onBackground,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.explore,
                    color: AppColors.accent,
                    size: 28,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: _places.length,
                  itemBuilder: (context, index) {
                    final place = _places[index];
                    return _buildPlaceCard(place);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceCard(PlaceData place) {
    return GestureDetector(
      onTap: () => _openInGoogleMaps(place.latitude, place.longitude, place.title),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  place.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.muted.withOpacity(0.3),
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 50,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: AppColors.muted.withOpacity(0.1),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      place.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      place.description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.map,
                    color: AppColors.accent,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlaceData {
  final String title;
  final String description;
  final String imageUrl;
  final double latitude;
  final double longitude;

  PlaceData({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
  });
}