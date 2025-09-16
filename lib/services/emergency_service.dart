import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyService {
  static const String _defaultEmergencyNumber = '100'; // Police emergency number in India
  
  // Mock family/trusted contacts (in real app, this would come from user preferences/storage)
  static final List<EmergencyContact> _emergencyContacts = [
    EmergencyContact(
      name: 'Emergency Services',
      phoneNumber: '100',
      isPrimary: true,
    ),
    EmergencyContact(
      name: 'Dad',
      phoneNumber: '+91 98765 43210',
      isPrimary: false,
    ),
    EmergencyContact(
      name: 'Mom',
      phoneNumber: '+91 87654 32109',
      isPrimary: false,
    ),
  ];

  /// Gets the primary emergency contact (not just the number)
  static EmergencyContact getPrimaryEmergencyContact() {
    return _emergencyContacts.firstWhere(
      (contact) => contact.isPrimary,
      orElse: () => EmergencyContact(
        name: 'Emergency Services',
        phoneNumber: _defaultEmergencyNumber,
        isPrimary: false,
      ),
    );
  }

  /// Gets the primary emergency contact phone number
  static String getPrimaryEmergencyNumber() {
    return getPrimaryEmergencyContact().phoneNumber;
  }

  /// Gets all emergency contacts
  static List<EmergencyContact> getAllEmergencyContacts() {
    return List.from(_emergencyContacts);
  }

  /// Makes a phone call to the specified number
  static Future<bool> makePhoneCall(String phoneNumber) async {
    try {
      // Clean the phone number (remove any spaces or special characters except +)
      final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
      final Uri phoneUri = Uri(scheme: 'tel', path: cleanNumber);
      
      if (await canLaunchUrl(phoneUri)) {
        // Use external application mode to ensure it opens in the phone app
        await launchUrl(
          phoneUri,
          mode: LaunchMode.externalApplication,
        );
        return true;
      } else {
        print('Cannot launch phone call to $phoneNumber');
        return false;
      }
    } catch (e) {
      print('Error making phone call: $e');
      return false;
    }
  }

  /// Calls the primary emergency contact
  static Future<bool> callPrimaryEmergencyContact() async {
    final phoneNumber = getPrimaryEmergencyNumber();
    HapticFeedback.heavyImpact(); // Provide strong haptic feedback
    return await makePhoneCall(phoneNumber);
  }

  /// Sends emergency alert to police (mock implementation)
  static Future<bool> alertPoliceStation() async {
    try {
      HapticFeedback.heavyImpact();
      
      // In a real implementation, this would:
      // 1. Get current location
      // 2. Send location and user details to backend
      // 3. Backend would notify nearby police stations
      // 4. Return success/failure status
      
      // Always return success immediately
      return true;
    } catch (e) {
      print('Error alerting police station: $e');
      return false;
    }
  }

  /// Gets current location for emergency alert (mock implementation)
  static Future<EmergencyLocation> getCurrentLocation() async {
    // In a real app, this would use location services
    await Future.delayed(const Duration(milliseconds: 500));
    
    return EmergencyLocation(
      latitude: 28.6139, // Delhi coordinates for demo
      longitude: 77.2090,
      address: 'New Delhi, India',
      timestamp: DateTime.now(),
    );
  }
}

class EmergencyContact {
  final String name;
  final String phoneNumber;
  final bool isPrimary;

  EmergencyContact({
    required this.name,
    required this.phoneNumber,
    required this.isPrimary,
  });
}

class EmergencyLocation {
  final double latitude;
  final double longitude;
  final String address;
  final DateTime timestamp;

  EmergencyLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.timestamp,
  });
}