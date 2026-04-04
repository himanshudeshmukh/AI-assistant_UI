// /// [AppColors] - Centralized color palette for the entire application
// ///
// /// This class defines all color constants used across the app to ensure
// /// consistency and make theme changes easy. All colors from the design mockup
// /// are defined here with proper naming conventions.
// ///
// /// Usage: AppColors.primaryOrange, AppColors.backgroundColor, etc.
//
 import 'package:flutter/material.dart';
//
// class AppColors {
//   // Private constructor to prevent instantiation
//   AppColors._();
//
//   // ==================== Primary Colors ====================
//   /// Primary orange color - used for buttons, highlights, and main actions
//   static const Color primaryOrange = Color(0xFF2D2A72);
//
//   /// Light orange/yellow - used for secondary accents and backgrounds
//   static const Color lightOrange = Color(0xFFA78BFA);
//
//   /// Darker orange - used for hover states and pressed states
//   static const Color darkOrange = Color(0xFFF57C00);
//
//   // ==================== Neutral Colors ====================
//   /// Background color - white/off-white for card and form backgrounds
//   static const Color backgroundColor = Color(0xFFF8F9FC);
//
//   /// Surface color - slightly off-white for containers
//   static const Color surfaceColor = Color(0xFFFFFFFF);
//
//   /// Text primary color - dark gray/black for main text
//   static const Color textPrimary = Color(0xFF1F1F1F);
//
//   /// Text secondary color - light gray for helper text and labels
//   static const Color textSecondary = Color(0xFF757575);
//
//   /// Text disabled color - very light gray for disabled states
//   static const Color textDisabled = Color(0xFFBDBDBD);
//
//   // ==================== Input Colors ====================
//   /// Input field border color - light gray
//   static const Color inputBorderColor = Color(0xFFBDBDBD);
//
//   /// Input field background color
//   static const Color inputBackgroundColor = Color(0xFFDDDDDD);
//
//   /// Input focus border color - primary orange when focused
//   static const Color inputFocusBorderColor = primaryOrange;
//
//   /// Placeholder text color
//   static const Color placeholderColor = Color(0xFF9E9E9E);
//
//   // ==================== Semantic Colors ====================
//   /// Error color - red for error states
//   static const Color errorColor = Color(0xFFD32F2F);
//
//   /// Error light background
//   static const Color errorLight = Color(0xFFFFEBEE);
//
//   /// Success color - green for success states
//   static const Color successColor = Color(0xFF388E3C);
//
//   /// Success light background
//   static const Color successLight = Color(0xFFC8E6C9);
//
//   // ==================== Social Login Colors ====================
//   /// Facebook blue color for social login button
//   static const Color facebookBlue = Color(0xFF1877F2);
//
//   // ==================== Transparent Colors ====================
//   /// Transparent overlay for modal/dialog backgrounds
//   static const Color scrimColor = Color(0x00000000);
//
//   /// Divider color - light gray line separators
//   static const Color dividerColor = Color(0xFFDDDDDD);
//
//   static const Color cardColor = Color(0xFFFFFFFF);
//
//   // ==================== Gradient Colors ====================
//   /// Primary gradient start (used for the wavy design element)
//   static const Color gradientStart = lightOrange;
//
//   /// Primary gradient end
//   static const Color gradientEnd = primaryOrange;
// }


class AppColors{
AppColors._();

static const Color background = Color(0xFFF7F7F5);
static const Color surface = Color(0xFFFFFFFF);
static const Color productSurface = Color(0xFFEFEDE9);
static const Color searchBackground = Color(0xFFE7EBEA);
static const Color chipBackground = Color(0xFFF2F2EF);
static const Color chipSelected = Color(0xFFE7E4DE);
static const Color border = Color(0xFFE6E2DD);
static const Color textPrimary = Color(0xFF20201E);
static const Color textSecondary = Color(0xFF91908B);
static const Color textMuted = Color(0xFFA7A6A0);
static const Color navActive = Color(0xFF1F1F1D);
static const Color navInactive = Color(0xFF9E9D98);
static const Color navHighlight = Color(0xFFE9E7E2);
static const Color floatingButton = Color(0xFF66635F);
static const Color avatarBackground = Color(0xFFF1D5C5);

static const Color olive_Gold = Color(0xFF8C7A2F);
static const Color dark_Olive = Color(0xFF6F5E0F);
static const Color muted_Mustard = Color(0xFFB7A84E);

static const Color oatMeal = Color(0xFFCFC7B8);
static const Color slightlyDarker = Color(0xFFBFB6A5);

static const Color mediumGrey = Color(0xFF5F5F5F);
static const Color dark_stale_grey = Color(0xFF3F4444);
static const Color deepCharcoal = Color(0xFF2F3A3A);

static const Color coolLightGreyBlue = Color(0xFFBFC6C8);
static const Color MutedGreyBlue = Color(0xFF9FA6A8);

static const Color denimBLue = Color(0xFF2F4F66);
static const Color darkNavy = Color(0xFF1F2E3A);


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


/// 🔥 PRIMARY BRAND (Header Gradient Feel)
static const Color primary = Color(0xFFE35D5B);       // main red
static const Color primaryDark = Color(0xFFD94C4A);   // deeper red
static const Color primaryLight = Color(0xFFF07A73);  // lighter red

/// 🔥 BACKGROUNDS
// static const Color background = Color(0xFFF4EDED);    // app bg (light pinkish)
// static const Color surface = Colors.white;            // cards
//
// /// 🔥 TEXT COLORS
// static const Color textPrimary = Color(0xFF1C1C1C);
// static const Color textSecondary = Color(0xFF6F6F6F);
// static const Color textMuted = Color(0xFF9E9E9E);
//
// /// 🔥 BORDER / DIVIDER
// static const Color border = Color(0xFFEAEAEA);
static const Color divider = Color(0xFFF0F0F0);

/// 🔥 LIVE STATUS (GREEN CARD)
static const Color liveBg = Color(0xFFE3F0E8);
static const Color liveBorder = Color(0xFFB7E0C2);
static const Color liveGreen = Color(0xFF34A853);

/// 🔥 ICON COLORS
static const Color iconPrimary = Color(0xFF333333);
static const Color iconMuted = Color(0xFF9E9E9E);

/// 🔥 STAT ICON COLORS
static const Color blue = Color(0xFF4A90E2);
static const Color yellow = Color(0xFFFFC107);
static const Color purple = Color(0xFF7E57C2);
static const Color green = Color(0xFF2ECC71);

/// 🔥 CHIP COLORS
static const Color chipBg = Color(0xFFF2F2F2);
static const Color chipText = Color(0xFF555555);

/// 🔥 ACTION CARDS
static const Color actionCardBg = Colors.white;

/// 🔥 BUTTON
static const Color buttonPrimary = Color(0xFFE04B3F);
static const Color buttonText = Colors.white;

/// 🔥 WARNING / INFO (Withdrawal Rules)
static const Color warningBg = Color(0xFFF8EFD8);
static const Color warningText = Color(0xFFB58B00);

/// 🔥 SHADOW (use with opacity)
static const Color shadow = Colors.black;

/// 🔥 WALLET CHIP
static const Color walletBg = Colors.white;



  // static const Color splashBg = Color(0xFFE35D5B);
  // static const Color waveColor = Color(0xFFF07A73);
  // static const Color textWhite = Colors.white;


  // static const Color splashBg = Color(0xFF11998E);
  //
  // /// GREEN
  // static const Color waveColor = Color(0xFF38EF7D);
  //
  // /// 1. Fresh Mint
  static const Color splashBg = Color(0xFF2EC4B6);
  static const Color waveColor = Color(0xFF90DBA4);

  /// 2. Deep Ocean (premium)
  // static const Color splashBg = Color(0xFF0F766E);
  // static const Color waveColor = Color(0xFF22C55E);

  // /// 3. Vibrant Neon
  // static const Color splashBg = Color(0xFF00C9A7);
  // static const Color waveColor = Color(0xFF00F260);

}