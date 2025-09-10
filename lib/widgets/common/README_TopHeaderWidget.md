# TopHeaderWidget

A reusable top header widget that provides consistent branding and emergency access across all main navigation pages in the Yatra Guardian app.

## Features

- **SOS Button**: Emergency access button with customizable tap behavior
- **App Title**: Displays "यात्रा Guardian" with proper Hindi font styling
- **Profile Icon**: User profile access with customizable tap behavior
- **Consistent Styling**: Maintains the same visual design across all pages

## Usage

### Basic Usage
```dart
import 'package:yatra_guardian/widgets/common/top_header_widget.dart';

// In your page's build method:
TopHeaderWidget(
  onBackground: const Color(0xFF111827), // Required: text/icon color
)
```

### With Custom Callbacks
```dart
TopHeaderWidget(
  onBackground: const Color(0xFF111827),
  onProfileTap: () {
    Navigator.pushNamed(context, '/profile');
  },
  onSOSTap: () {
    // Custom emergency handling
    _handleCustomSOS();
  },
)
```

### In a Page Layout
```dart
Scaffold(
  backgroundColor: const Color(0xFFF4F5F7),
  body: SafeArea(
    child: Column(
      children: [
        // Top header - always first
        TopHeaderWidget(onBackground: const Color(0xFF111827)),
        
        // Your page content
        Expanded(
          child: YourPageContent(),
        ),
      ],
    ),
  ),
)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `onBackground` | `Color` | Yes | Color for text and icons |
| `onProfileTap` | `VoidCallback?` | No | Custom profile tap handler. If null, uses default behavior |
| `onSOSTap` | `VoidCallback?` | No | Custom SOS tap handler. If null, shows default SOS dialog |

## Default Behaviors

- **SOS Button**: Shows an emergency dialog with "Send SOS" confirmation
- **Profile Icon**: Shows placeholder behavior (ready for profile navigation)

## Implementation Examples

### Home Page
```dart
// Already implemented in lib/screens/home/home_page.dart
TopHeaderWidget(onBackground: onBackground)
```

### Navigation Pages
```dart
// Already implemented in lib/widgets/layout/main_layout.dart for:
// - Explore Page
// - Emergency Page  
// - Alerts Page
TopHeaderWidget(onBackground: onBackground)
```

### Create Trip Page
```dart
// Already implemented in lib/screens/trip/create_trip_page.dart
TopHeaderWidget(onBackground: onBackground)
```

## Styling

The widget uses consistent styling:
- SOS Button: Red-themed emergency button with glow effect
- Title: Mixed Hindi/English with proper font weights
- Profile: White circular container with shadow
- Spacing: 16px padding on all sides

## Dependencies

- `google_fonts`: For Hindi text rendering
- `flutter/material.dart`: For UI components

## Notes

- The widget automatically handles SafeArea padding
- SOS functionality is ready for backend integration
- Profile navigation is ready for implementation
- All visual elements maintain the app's design system
