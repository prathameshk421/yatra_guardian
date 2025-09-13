import 'package:flutter/material.dart';
import '../../models/trip_model.dart';
import '../../theme/app_colors.dart';
import '../../services/trip_service.dart';
import 'trip_details_page.dart';

class TripListPage extends StatefulWidget {
  const TripListPage({super.key});

  @override
  State<TripListPage> createState() => _TripListPageState();
}

class _TripListPageState extends State<TripListPage> {
  List<Trip> _trips = [];
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadTrips();
  }

  Future<void> _loadTrips() async {
    try {
      setState(() {
        _isLoading = true;
        _error = '';
      });

      // Mock data for demonstration - replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      
      final mockTrips = [
        Trip(
          id: 'trip_1757437199588_bpdolvdr6',
          title: 'Goa Beach Resort',
          destination: 'Goa, India',
          startDate: DateTime.now().subtract(const Duration(days: 2)),
          endDate: DateTime.now().add(const Duration(days: 3)),
          joinedUsers: ['user1', 'user2', 'user3'],
          groupId: 'group_123',
          events: [
            TripEvent(
              id: 'event1',
              type: 'Check-in',
              location: 'Hotel Check-in',
              time: DateTime.now().subtract(const Duration(days: 2)),
            ),
            TripEvent(
              id: 'event2',
              type: 'Activity',
              location: 'Beach Visit',
              time: DateTime.now().subtract(const Duration(days: 1)),
            ),
          ],
          status: 'active',
          imageUrl: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400&q=80',
        ),
        Trip(
          id: 'trip_1757437199589_abc123',
          title: 'Sikkim Adventure',
          destination: 'Sikkim, India',
          startDate: DateTime.now().add(const Duration(days: 7)),
          endDate: DateTime.now().add(const Duration(days: 14)),
          joinedUsers: ['user1', 'user4'],
          events: [],
          status: 'upcoming',
          imageUrl: 'https://images.unsplash.com/photo-1506905925346-14bda5d4d4a3?w=400&q=80',
        ),
        Trip(
          id: 'trip_1757437199590_def456',
          title: 'Mumbai Gateway',
          destination: 'Mumbai, India',
          startDate: DateTime.now().subtract(const Duration(days: 30)),
          endDate: DateTime.now().subtract(const Duration(days: 25)),
          joinedUsers: ['user1', 'user2'],
          events: [
            TripEvent(
              id: 'event3',
              type: 'Check-in',
              location: 'Hotel Check-in',
              time: DateTime.now().subtract(const Duration(days: 30)),
            ),
          ],
          status: 'completed',
          imageUrl: 'https://images.unsplash.com/photo-1524661135-423995f22d0b?w=400&q=80',
        ),
        Trip(
          id: 'trip_1757437199591_ghi789',
          title: 'Kerala Backwaters',
          destination: 'Kerala, India',
          startDate: DateTime.now().add(const Duration(days: 21)),
          endDate: DateTime.now().add(const Duration(days: 28)),
          joinedUsers: ['user1', 'user3', 'user5'],
          groupId: 'group_456',
          events: [],
          status: 'upcoming',
          imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&q=80',
        ),
        Trip(
          id: 'trip_1757437199592_jkl012',
          title: 'Rajasthan Desert',
          destination: 'Rajasthan, India',
          startDate: DateTime.now().subtract(const Duration(days: 60)),
          endDate: DateTime.now().subtract(const Duration(days: 55)),
          joinedUsers: ['user1'],
          events: [],
          status: 'completed',
          imageUrl: 'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=400&q=80',
        ),
      ];

      setState(() {
        _trips = mockTrips;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  List<Trip> get _sortedTrips {
    final activeTrips = _trips.where((trip) => trip.status == 'active').toList();
    final upcomingTrips = _trips.where((trip) => trip.status == 'upcoming').toList();
    final completedTrips = _trips.where((trip) => trip.status == 'completed').toList();

    // Sort each category by date
    activeTrips.sort((a, b) => b.startDate.compareTo(a.startDate));
    upcomingTrips.sort((a, b) => a.startDate.compareTo(b.startDate));
    completedTrips.sort((a, b) => b.startDate.compareTo(a.startDate));

    return [...activeTrips, ...upcomingTrips, ...completedTrips];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: AppColors.scaffold,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onBackground),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Your Trips',
          style: TextStyle(
            color: AppColors.onBackground,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.accent),
            onPressed: _loadTrips,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
        ),
      );
    }

    if (_error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.muted,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading trips',
              style: TextStyle(
                color: AppColors.onBackground,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadTrips,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_trips.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.trip_origin_rounded,
              color: AppColors.muted,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'No trips found',
              style: TextStyle(
                color: AppColors.onBackground,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Start by creating your first trip',
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: _sortedTrips.map((trip) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _TripCard(
              trip: trip,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TripDetailsPage(trip: trip),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback onTap;

  const _TripCard({
    required this.trip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
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
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: trip.imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(trip.imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: trip.imageUrl == null ? AppColors.accent.withOpacity(0.1) : null,
                  ),
                  child: trip.imageUrl == null
                      ? Icon(
                          Icons.trip_origin_rounded,
                          color: AppColors.accent,
                          size: 30,
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.title,
                        style: const TextStyle(
                          color: AppColors.onBackground,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        trip.destination,
                        style: const TextStyle(
                          color: AppColors.muted,
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
                              color: _getStatusColor(trip.status).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              trip.status.toUpperCase(),
                              style: TextStyle(
                                color: _getStatusColor(trip.status),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.people,
                            color: AppColors.muted,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${trip.joinedUsers.length}',
                            style: const TextStyle(
                              color: AppColors.muted,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.muted,
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: AppColors.muted,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  '${_formatDate(trip.startDate)} - ${_formatDate(trip.endDate)}',
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                if (trip.events.isNotEmpty) ...[
                  Icon(
                    Icons.event,
                    color: AppColors.muted,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${trip.events.length} events',
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'upcoming':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      default:
        return AppColors.muted;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
