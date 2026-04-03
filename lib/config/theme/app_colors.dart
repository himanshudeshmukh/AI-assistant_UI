/// [AppColors] - Centralized color palette for the entire application
///
/// This class defines all color constants used across the app to ensure
/// consistency and make theme changes easy. All colors from the design mockup
/// are defined here with proper naming conventions.
///
/// Usage: AppColors.primaryOrange, AppColors.backgroundColor, etc.
library;

import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // ==================== Primary Colors ====================
  /// Primary orange color - used for buttons, highlights, and main actions
  static const Color primaryOrange = Color(0xFF2D2A72);

  /// Light orange/yellow - used for secondary accents and backgrounds
  static const Color lightOrange = Color(0xFFA78BFA);

  /// Darker orange - used for hover states and pressed states
  static const Color darkOrange = Color(0xFFF57C00);

  // ==================== Neutral Colors ====================
  /// Background color - white/off-white for card and form backgrounds
  static const Color backgroundColor = Color(0xFFF8F9FC);

  /// Surface color - slightly off-white for containers
  static const Color surfaceColor = Color(0xFFFFFFFF);

  /// Text primary color - dark gray/black for main text
  static const Color textPrimary = Color(0xFF1F1F1F);

  /// Text secondary color - light gray for helper text and labels
  static const Color textSecondary = Color(0xFF757575);

  /// Text disabled color - very light gray for disabled states
  static const Color textDisabled = Color(0xFFBDBDBD);

  // ==================== Input Colors ====================
  /// Input field border color - light gray
  static const Color inputBorderColor = Color(0xFFBDBDBD);

  /// Input field background color
  static const Color inputBackgroundColor = Color(0xFFDDDDDD);

  /// Input focus border color - primary orange when focused
  static const Color inputFocusBorderColor = primaryOrange;

  /// Placeholder text color
  static const Color placeholderColor = Color(0xFF9E9E9E);

  // ==================== Semantic Colors ====================
  /// Error color - red for error states
  static const Color errorColor = Color(0xFFD32F2F);

  /// Error light background
  static const Color errorLight = Color(0xFFFFEBEE);

  /// Success color - green for success states
  static const Color successColor = Color(0xFF388E3C);

  /// Success light background
  static const Color successLight = Color(0xFFC8E6C9);

  // ==================== Social Login Colors ====================
  /// Facebook blue color for social login button
  static const Color facebookBlue = Color(0xFF1877F2);

  // ==================== Transparent Colors ====================
  /// Transparent overlay for modal/dialog backgrounds
  static const Color scrimColor = Color(0x00000000);

  /// Divider color - light gray line separators
  static const Color dividerColor = Color(0xFFDDDDDD);

  static const Color cardColor = Color(0xFFFFFFFF);

  // ==================== Gradient Colors ====================
  /// Primary gradient start (used for the wavy design element)
  static const Color gradientStart = lightOrange;

  /// Primary gradient end
  static const Color gradientEnd = primaryOrange;

  // ==================== Victus-style auth (hero) screens ====================
  /// Dark hero background behind image header
  static const Color authHeroBackground = Color(0xFF0A0A0A);

  /// Gold accent used in hero headers and links
  static const Color authHeroAccent = Color(0xFFC8A97E);

  /// White card surface under the hero
  static const Color authCardSurface = Color(0xFFFFFFFF);

  /// Primary text on the auth card (near-black)
  static const Color authTextOnCard = Color(0xFF0A0A0A);

  /// Secondary / body text on auth card
  static const Color authTextSecondary = Color(0xFF8A8A8A);

  /// Muted helper text
  static const Color authTextMuted = Color(0xFFB0B0B0);

  /// Input borders on auth card
  static const Color authInputBorder = Color(0xFFE5E5E5);

  /// Input prefix / suffix icons
  static const Color authInputIcon = Color(0xFFBFBFBF);

  /// Placeholder text in auth fields
  static const Color authPlaceholder = Color(0xFFCCCCCC);

  /// Divider on auth card
  static const Color authDivider = Color(0xFFEBEBEB);

  /// Social button label color
  static const Color authSocialLabel = Color(0xFF3A3A3A);

  /// Filled primary CTA on auth card (dark pill)
  static const Color authPrimaryButton = Color(0xFF0A0A0A);
}
