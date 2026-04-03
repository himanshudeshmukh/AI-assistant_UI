/// [NavigationConstants] - Centralized navigation configuration
///
/// Maintains all navigation-related constants to ensure consistency
/// across the application and make changes maintainable from a single point.
///
/// Following: DRY principle, Configuration Management best practices
library;

class NavigationConstants {
  // Private constructor to prevent instantiation
  NavigationConstants._();

  // ==================== Route Names ====================
  /// Home screen route name
  static const String homeRoute = '/home';

  /// Profile screen route name
  static const String profileRoute = '/profile';

  /// Camera screen route name
  static const String cameraRoute = '/camera';

  // ==================== Navigation Indices ====================
  /// Home tab index in bottom navigation
  static const int homeIndex = 0;

  /// Profile tab index in bottom navigation
  static const int profileIndex = 1;

  /// Camera (center FAB) index - not a regular tab
  static const int cameraIndex = 2;

  /// Total number of bottom navigation items (excluding center FAB)
  static const int bottomNavItemCount = 2;

  // ==================== Animation Durations ====================
  /// Standard animation duration for tab transitions
  static const Duration navAnimationDuration = Duration(milliseconds: 300);

  /// FAB button press animation duration
  static const Duration fabAnimationDuration = Duration(milliseconds: 200);

  // ==================== Dimensions ====================
  /// Height of bottom navigation bar (includes SafeArea)
  static const double bottomNavHeight = 80.0;

  /// Diameter of center FAB button
  static const double fabDiameter = 72.0;

  /// Icon size for navigation items
  static const double navIconSize = 28.0;

  /// Icon size for FAB center icon
  static const double fabIconSize = 32.0;

  /// Label text size for navigation items
  static const double navLabelSize = 12.0;

  /// Spacing between icon and label in nav items
  static const double iconLabelSpacing = 8.0;

  // ==================== Elevation Values ====================
  /// Elevation of bottom navigation bar
  static const double navBarElevation = 8.0;

  /// Elevation of center FAB button
  static const double fabElevation = 12.0;

  // ==================== Scale Values ====================
  /// Default scale for FAB button
  static const double fabDefaultScale = 1.0;

  /// Scale when FAB button is pressed
  static const double fabPressedScale = 1.15;
}