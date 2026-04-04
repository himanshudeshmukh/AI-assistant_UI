/// [AppDimensions] - Centralized spacing and sizing constants (OPTIMIZED)
///
/// Defines all dimensions like padding, margins, border radius, and icon sizes
/// used throughout the application. Following Material Design 3 guidelines.
///
/// ✅ OPTIMIZED FOR COMPACT MOBILE UI:
/// - Input fields: 46px → 40px
/// - Button height: 56px → 48px
/// - Card padding: 20px → 16px
///
/// Usage: AppDimensions.paddingXL, AppDimensions.borderRadiusLarge, etc.
library;

import 'package:flutter/cupertino.dart';

class AppDimensions {
  // Private constructor to prevent instantiation
  AppDimensions._();

  // ==================== Padding/Margin Spacing ====================
  /// Extra small spacing - 4dp
  static const double paddingXS = 4.0;

  /// Small spacing - 8dp
  static const double paddingS = 8.0;

  /// Medium spacing - 12dp
  static const double paddingM = 12.0;

  /// Default spacing - 16dp (Most commonly used)
  static const double paddingL = 16.0;

  /// Large spacing - 24dp
  static const double paddingXL = 24.0;

  /// Extra large spacing - 32dp
  static const double paddingXXL = 32.0;

  /// Screen horizontal padding
  static const double screenPaddingHorizontal = 40.0;

  /// Screen vertical padding
  static const double screenPaddingVertical = 14.0;

  // ==================== Border Radius ====================
  /// Extra small border radius - 4dp
  static const double borderRadiusXS = 4.0;

  /// Small border radius - 8dp
  static const double borderRadiusS = 8.0;

  /// Medium border radius - 12dp
  static const double borderRadiusM = 12.0;

  /// Large border radius - 16dp
  static const double borderRadiusL = 16.0;

  /// Extra large border radius - 20dp
  static const double borderRadiusXL = 20.0;

  /// Full circle border radius - used for circular avatars
  static const double borderRadiusFull = 50.0;

  // ==================== Icon Sizes ====================
  /// Extra small icon - 16x16dp
  static const double iconXS = 16.0;

  /// Small icon - 20x20dp
  static const double iconS = 20.0;

  /// Medium icon - 24x24dp (Standard)
  static const double iconM = 24.0;

  /// Large icon - 32x32dp
  static const double iconL = 32.0;

  /// Extra large icon - 48x48dp
  static const double iconXL = 48.0;

  // ==================== Input Field Dimensions ====================
  /// ✅ OPTIMIZED: Standard input field height (was 46, now 40)
  static const double inputFieldHeight = 40.0;

  /// Input field border width
  static const double inputBorderWidth = 1.0;

  /// Input field focus border width (appears thicker when focused)
  static const double inputFocusBorderWidth = 2.0;

  /// Input field horizontal padding
  static const double inputPaddingHorizontal = 16.0;

  /// Input field vertical padding
  static const double inputPaddingVertical = 14.0;

  // ==================== Button Dimensions ====================
  /// ✅ OPTIMIZED: Standard button height (was 56, now 48)
  static const double buttonHeight = 48.0;

  /// Small button height
  static const double buttonHeightSmall = 40.0;

  /// Button border radius
  static const double buttonBorderRadius = 12.0;

  /// Button horizontal padding
  static const double buttonPaddingHorizontal = 24.0;

  /// Button vertical padding
  static const double buttonPaddingVertical = 12.0;

  // ==================== Card/Container Dimensions ====================
  /// Standard card elevation
  static const double cardElevation = 2.0;

  /// Card border radius
  static const double cardBorderRadius = 16.0;

  /// ✅ OPTIMIZED: Card padding (was 20, now 16)
  static const double cardPadding = 16.0;

  // ==================== Animation Durations ====================
  /// Fast animation duration - 150ms
  static const Duration animationDurationFast = Duration(milliseconds: 150);

  /// Standard animation duration - 300ms
  static const Duration animationDurationNormal = Duration(milliseconds: 300);

  /// Slow animation duration - 500ms
  static const Duration animationDurationSlow = Duration(milliseconds: 500);

  /// Very slow animation duration - 800ms (for page transitions)
  static const Duration animationDurationVerySlow = Duration(milliseconds: 800);

  // ==================== Divider Dimensions ====================
  /// Divider thickness
  static const double dividerThickness = 1.0;

  /// Divider height (space occupied by divider)
  static const double dividerHeight = 16.0;

  // ==================== Dialog Dimensions ====================
  /// Dialog width on tablet/desktop
  static const double dialogMaxWidth = 600.0;

  /// Dialog border radius
  static const double dialogBorderRadius = 20.0;
}
