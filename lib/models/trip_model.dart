class TripEvent {
  final String id;
  final String type;
  final String location;
  final DateTime time;
  final String? description;

  TripEvent({
    required this.id,
    required this.type,
    required this.location,
    required this.time,
    this.description,
  });

  factory TripEvent.fromJson(Map<String, dynamic> json) {
    return TripEvent(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      location: json['location'] ?? '',
      time: DateTime.parse(json['time']),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'location': location,
      'time': time.toIso8601String(),
      'description': description,
    };
  }
}

class Trip {
  final String id;
  final String title;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> joinedUsers;
  final String? groupId;
  final List<TripEvent> events;
  final String status; // 'active', 'upcoming', 'completed'
  final String? imageUrl;

  Trip({
    required this.id,
    required this.title,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.joinedUsers,
    this.groupId,
    required this.events,
    required this.status,
    this.imageUrl,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      destination: json['destination'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      joinedUsers: List<String>.from(json['joinedUsers'] ?? []),
      groupId: json['groupId'],
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => TripEvent.fromJson(e))
          .toList() ?? [],
      status: json['status'] ?? 'upcoming',
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'destination': destination,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'joinedUsers': joinedUsers,
      'groupId': groupId,
      'events': events.map((e) => e.toJson()).toList(),
      'status': status,
      'imageUrl': imageUrl,
    };
  }

  Trip copyWith({
    String? title,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? joinedUsers,
    String? groupId,
    List<TripEvent>? events,
    String? status,
    String? imageUrl,
  }) {
    return Trip(
      id: id,
      title: title ?? this.title,
      destination: destination ?? this.destination,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      joinedUsers: joinedUsers ?? this.joinedUsers,
      groupId: groupId ?? this.groupId,
      events: events ?? this.events,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  bool get isEditable => status == 'active' || status == 'upcoming';
}
