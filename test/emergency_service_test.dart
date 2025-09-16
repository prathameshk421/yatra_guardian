// Test file to verify emergency service functionality
// This would normally be in the test/ directory

import 'package:flutter_test/flutter_test.dart';
import '../lib/services/emergency_service.dart';

void main() {
  group('EmergencyService Tests', () {
    test('Should return primary emergency contact', () {
      final contact = EmergencyService.getPrimaryEmergencyContact();
      expect(contact.name, 'Dad');
      expect(contact.phoneNumber, '+91 98765 43210');
      expect(contact.isPrimary, true);
    });

    test('Should return primary emergency number', () {
      final number = EmergencyService.getPrimaryEmergencyNumber();
      expect(number, '+91 98765 43210');
    });

    test('Should return all emergency contacts', () {
      final contacts = EmergencyService.getAllEmergencyContacts();
      expect(contacts.length, 3);
      expect(contacts.any((c) => c.name == 'Dad'), true);
      expect(contacts.any((c) => c.name == 'Mom'), true);
      expect(contacts.any((c) => c.name == 'Emergency Services'), true);
    });

    test('Should get current location (mock)', () async {
      final location = await EmergencyService.getCurrentLocation();
      expect(location.latitude, 28.6139);
      expect(location.longitude, 77.2090);
      expect(location.address, 'New Delhi, India');
    });
  });
}