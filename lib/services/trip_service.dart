import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class TripService {
  static const String baseUrl = 'http://localhost:5050';
  
  static Future<Map<String, dynamic>?> createTrip({
    required String userId,
    required String title,
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    List<String> invitePublicIds = const [],
    List<String> inviteEmails = const [],
  }) async {
    try {
      final requestBody = {
        'userId': userId,
        'title': title,
        'destination': destination,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'invitePublicIds': invitePublicIds,
        'inviteEmails': inviteEmails,
      };
      
      if (kDebugMode) {
        print('Creating trip with data: ${json.encode(requestBody)}');
      }
      
      final response = await http.post(
        Uri.parse('$baseUrl/api/trips'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );
      
      if (kDebugMode) {
        print('Trip creation response: ${response.statusCode} - ${response.body}');
      }
      
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData;
      } else {
        final errorData = json.decode(response.body);
        throw 'Failed to create trip: ${errorData['error'] ?? 'Unknown error'}';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error creating trip: $e');
      }
      rethrow;
    }
  }
  
  static Future<List<Map<String, dynamic>>> getUserTrips(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/trips/user/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return List<Map<String, dynamic>>.from(responseData['trips'] ?? []);
        } else {
          throw 'Failed to get trips: ${responseData['error'] ?? 'Unknown error'}';
        }
      } else {
        final errorData = json.decode(response.body);
        throw 'Failed to get trips: ${errorData['error'] ?? 'Unknown error'}';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting user trips: $e');
      }
      rethrow;
    }
  }
  
  static Future<Map<String, dynamic>?> addItineraryEvent({
    required String tripId,
    required String ownerUserId,
    required Map<String, dynamic> event,
  }) async {
    try {
      final requestBody = {
        'ownerUserId': ownerUserId,
        'event': event,
      };
      
      final response = await http.post(
        Uri.parse('$baseUrl/api/trips/$tripId/events'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final errorData = json.decode(response.body);
        throw 'Failed to add event: ${errorData['error'] ?? 'Unknown error'}';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding itinerary event: $e');
      }
      rethrow;
    }
  }
}