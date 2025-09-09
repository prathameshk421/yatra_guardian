# Project Structure Documentation

## Overview
This Flutter project follows a well-organized, scalable architecture with clear separation of concerns.

## Folder Structure

```
lib/
├── app.dart                    # Main app configuration
├── main.dart                   # Entry point
├── constants/                  # App-wide constants
│   └── app_strings.dart       # String constants
├── theme/                      # Theme and styling
│   ├── app_colors.dart        # Color palette
│   └── app_theme.dart         # Theme configuration
├── screens/                    # Application screens
│   └── home/                  # Home screen module
│       ├── home_page.dart     # Main home page
│       └── widgets/           # Home-specific widgets
│           └── top_tab.dart   # Tab navigation widget
├── widgets/                    # Reusable widgets
│   ├── common/                # Common UI components
│   │   ├── custom_app_bar.dart
│   │   ├── custom_bottom_nav_bar.dart
│   │   ├── section_header.dart
│   │   └── index.dart         # Export file
│   └── cards/                 # Card-based widgets
│       ├── hero_card.dart
│       ├── category_pill.dart
│       ├── coupon_banner.dart
│       ├── promo_card.dart
│       ├── small_promo_card.dart
│       ├── vip_status_card.dart
│       └── index.dart         # Export file
└── utils/                     # Utility functions (ready for future use)
```

## Architecture Benefits

### 1. **Modularity**
- Each widget has its own file
- Related components are grouped together
- Easy to locate and modify specific features

### 2. **Reusability**
- Common widgets can be used across different screens
- Consistent theming and styling
- Centralized constants for easy maintenance

### 3. **Scalability**
- Clear structure for adding new features
- Easy to add new screens and widgets
- Prepared for state management integration

### 4. **Maintainability**
- Single responsibility principle
- Clear naming conventions
- Organized imports with index files

## Usage Guidelines

### Adding New Screens
1. Create a new folder in `screens/`
2. Add the main page file
3. Create a `widgets/` subfolder for screen-specific components

### Adding New Widgets
1. Place reusable widgets in `widgets/common/`
2. Place specific widget types in appropriate subfolders
3. Update the corresponding `index.dart` file

### Adding New Constants
1. Add to `constants/app_strings.dart` for text
2. Add to `theme/app_colors.dart` for colors
3. Add to `theme/app_theme.dart` for styles

### Adding New Utilities
1. Create new files in `utils/` folder
2. Follow single responsibility principle

## Best Practices Implemented

1. **Consistent Naming**: Clear, descriptive file and class names
2. **Separation of Concerns**: UI, theme, and constants are separate
3. **Index Files**: Simplify imports with barrel exports
4. **Theme Centralization**: All styling in dedicated theme files
5. **Widget Decomposition**: Large components split into smaller, manageable pieces

This structure provides a solid foundation for scaling the Yatra Guardian app while maintaining code quality and developer productivity.
