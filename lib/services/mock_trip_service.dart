import '../models/trip_model.dart';

class MockTripService {
  static List<Trip> getMockTrips() {
    return [
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
      Trip(
        id: 'trip_1757437199593_mno345',
        title: 'Delhi Heritage Tour',
        destination: 'Delhi, India',
        startDate: DateTime.now().add(const Duration(days: 10)),
        endDate: DateTime.now().add(const Duration(days: 13)),
        joinedUsers: ['user1', 'user2', 'user4', 'user6'],
        groupId: 'group_789',
        events: [],
        status: 'upcoming',
        imageUrl: 'https://images.unsplash.com/photo-1705524220998-4b4b51bd12f6?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cmVkJTIwZm9ydHxlbnwwfDF8MHx8fDI%3D',
      ),
      Trip(
        id: 'trip_1757437199594_pqr678',
        title: 'Amritsar Spiritual Journey',
        destination: 'Amritsar, India',
        startDate: DateTime.now().add(const Duration(days: 35)),
        endDate: DateTime.now().add(const Duration(days: 39)),
        joinedUsers: ['user1', 'user3', 'user7'],
        groupId: 'group_101',
        events: [],
        status: 'upcoming',
        imageUrl: 'https://images.unsplash.com/photo-1623059508779-2542c6e83753?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Z29sZGVuJTIwdGVtcGxlfGVufDB8MXwwfHx8Mg%3D%3D',
      ),
    ];
  }

  static Future<List<Trip>> loadTrips() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return getMockTrips();
  }

  static Trip? getCurrentTrip() {
    final trips = getMockTrips();
    return trips.where((trip) => trip.status == 'active').firstOrNull;
  }

  static List<Trip> getSortedTrips() {
    final trips = getMockTrips();
    final activeTrips = trips.where((trip) => trip.status == 'active').toList();
    final upcomingTrips = trips.where((trip) => trip.status == 'upcoming').toList();
    final completedTrips = trips.where((trip) => trip.status == 'completed').toList();

    // Sort each category by date
    activeTrips.sort((a, b) => b.startDate.compareTo(a.startDate));
    upcomingTrips.sort((a, b) => a.startDate.compareTo(b.startDate));
    completedTrips.sort((a, b) => b.startDate.compareTo(a.startDate));

    return [...activeTrips, ...upcomingTrips, ...completedTrips];
  }

  static Map<String, int> getTripStats() {
    final trips = getMockTrips();
    final Set<String> citiesVisited = {};
    
    for (final trip in trips) {
      // Extract city from destination (e.g., "Goa, India" -> "Goa")
      final city = trip.destination.split(',').first.trim();
      citiesVisited.add(city);
    }

    return {
      'totalTrips': trips.length,
      'citiesVisited': citiesVisited.length,
      'completedTrips': trips.where((trip) => trip.status == 'completed').length,
      'upcomingTrips': trips.where((trip) => trip.status == 'upcoming').length,
      'activeTrips': trips.where((trip) => trip.status == 'active').length,
    };
  }
}

extension IterableExtension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}