# SOS Button Functionality

## Overview
The SOS button in the Yatra Guardian app provides two emergency features:
1. **Single Tap**: Calls primary emergency contact
2. **Long Press**: Alerts nearby police stations

## Features Implemented

### 1. Emergency Contact Calling
- **Trigger**: Single tap on SOS button
- **Action**: Opens phone app and initiates call to primary emergency contact
- **Feedback**: Shows snackbar with contact details and call status
- **Fallback**: If primary contact call fails, shows retry option

### 2. Police Station Alert
- **Trigger**: Long press (hold) SOS button  
- **Action**: Shows confirmation dialog, then sends alert to nearby police stations
- **Process**: 
  - Confirmation dialog with warning about genuine emergencies
  - Loading indicator while sending alert
  - Success/failure feedback with current location
  - Fallback to emergency call if alert fails

### 3. Visual & Haptic Feedback
- **Pulsing animation** on SOS button to indicate it's active
- **Press animation** when button is touched
- **Haptic feedback**: Light impact on tap, heavy impact on long press
- **Color-coded dialogs** for different alert types

## Configuration

### Emergency Contacts
Currently configured in `lib/services/emergency_service.dart`:
```dart
static final List<EmergencyContact> _emergencyContacts = [
  EmergencyContact(
    name: 'Dad',
    phoneNumber: '+91 98765 43210',
    isPrimary: true,  // This will be called on single tap
  ),
  EmergencyContact(
    name: 'Mom', 
    phoneNumber: '+91 87654 32109',
    isPrimary: false,
  ),
  // ... more contacts
];
```

### Permissions Added

#### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.CALL_PHONE" />
<uses-permission android:name="android.permission.CALL_PRIVILEGED" />
```

#### iOS (`ios/Runner/Info.plist`)
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>tel</string>
    <string>mailto</string>
    <string>sms</string>
</array>
```

## Testing

### On Simulator
- Single tap will show calling indication but won't actually dial (simulators don't support calls)
- Long press will show full police alert flow with mock backend response

### On Real Device
- Single tap will open phone app and dial the primary emergency contact
- Long press will show police alert confirmation and simulate backend API call
- All haptic feedback and animations will work as intended

## Usage Instructions

### For Users
1. **Emergency Call**: Tap the red SOS button once to immediately call your primary emergency contact
2. **Police Alert**: Hold down the SOS button for 1+ seconds to alert nearby police stations
3. **Follow prompts**: Confirm actions in dialogs and wait for feedback

### For Developers
- Emergency contacts can be configured in `EmergencyService`
- Backend integration needed for `alertPoliceStation()` method
- Location services integration needed for `getCurrentLocation()` method
- Replace mock implementations with real API calls

## Backend Integration Needed

The following methods currently use mock implementations:
- `EmergencyService.alertPoliceStation()` - Needs real API to notify police
- `EmergencyService.getCurrentLocation()` - Needs real location services
- Contact management - Should integrate with user preferences/storage

## Dependencies
- `url_launcher: ^6.2.4` - For making phone calls
- Flutter's built-in `services` - For haptic feedback
- Standard Flutter material widgets for UI

## Files Modified
- `lib/services/emergency_service.dart` - New service for emergency functionality
- `lib/widgets/common/top_header_widget.dart` - Enhanced SOS button
- `android/app/src/main/AndroidManifest.xml` - Phone call permissions
- `ios/Runner/Info.plist` - URL scheme permissions
- `test/emergency_service_test.dart` - Unit tests for service

The SOS button is now fully functional and ready for production use with proper backend integration.