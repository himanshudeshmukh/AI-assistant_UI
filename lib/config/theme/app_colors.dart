// // library;
// //
// // import 'package:flutter/material.dart';
// //
// // class AppColors {
// //   // Private constructor to prevent instantiation
// //   AppColors._();
// //
// //   // ==================== Primary Colors ====================
// //   /// Primary orange color - used for buttons, highlights, and main actions
// //   static const Color primaryOrange = Color(0xFF2D2A72);
// //
// //   /// Light orange/yellow - used for secondary accents and backgrounds
// //   static const Color lightOrange = Color(0xFFA78BFA);
// //
// //   /// Darker orange - used for hover states and pressed states
// //   static const Color darkOrange = Color(0xFFF57C00);
// //
// //   // ==================== Neutral Colors ====================
// //   /// Background color - white/off-white for card and form backgrounds
// //   static const Color backgroundColor = Color(0xFFF8F9FC);
// //
// //   /// Surface color - slightly off-white for containers
// //   static const Color surfaceColor = Color(0xFFFFFFFF);
// //
// //   /// Text primary color - dark gray/black for main text
// //   static const Color textPrimary = Color(0xFF1F1F1F);
// //
// //   /// Text secondary color - light gray for helper text and labels
// //   static const Color textSecondary = Color(0xFF757575);
// //
// //   /// Text disabled color - very light gray for disabled states
// //   static const Color textDisabled = Color(0xFFBDBDBD);
// //
// //   // ==================== Input Colors ====================
// //   /// Input field border color - light gray
// //   static const Color inputBorderColor = Color(0xFFBDBDBD);
// //
// //   /// Input field background color
// //   static const Color inputBackgroundColor = Color(0xFFDDDDDD);
// //
// //   /// Input focus border color - primary orange when focused
// //   static const Color inputFocusBorderColor = primaryOrange;
// //
// //   /// Placeholder text color
// //   static const Color placeholderColor = Color(0xFF9E9E9E);
// //
// //   // ==================== Semantic Colors ====================
// //   /// Error color - red for error states
// //   static const Color errorColor = Color(0xFFD32F2F);
// //
// //   /// Error light background
// //   static const Color errorLight = Color(0xFFFFEBEE);
// //
// //   /// Success color - green for success states
// //   static const Color successColor = Color(0xFF388E3C);
// //
// //   /// Success light background
// //   static const Color successLight = Color(0xFFC8E6C9);
// //
// //   // ==================== Social Login Colors ====================
// //   /// Facebook blue color for social login button
// //   static const Color facebookBlue = Color(0xFF1877F2);
// //
// //   // ==================== Transparent Colors ====================
// //   /// Transparent overlay for modal/dialog backgrounds
// //   static const Color scrimColor = Color(0x00000000);
// //
// //   /// Divider color - light gray line separators
// //   static const Color dividerColor = Color(0xFFDDDDDD);
// //
// //   static const Color cardColor = Color(0xFFFFFFFF);
// //
// //   // ==================== Victus-style auth (hero) screens ====================
// //   /// Dark hero background behind image header
// //   static const Color authHeroBackground = Color(0xFF0A0A0A);
// //
// //   /// Gold accent used in hero headers and links
// //   static const Color authHeroAccent = Color(0xFFDDDDDD);
// //
// //   /// White card surface under the hero
// //   static const Color authCardSurface = Color(0xFFFFFFFF);
// //
// //   /// Primary text on the auth card (near-black)
// //   static const Color authTextOnCard = Color(0xFF0A0A0A);
// //
// //   /// Secondary / body text on auth card
// //   static const Color authTextSecondary = Color(0xFF8A8A8A);
// //
// //   /// Muted helper text
// //   static const Color authTextMuted = Color(0xFFB0B0B0);
// //
// //   /// Input borders on auth card
// //   static const Color authInputBorder = Color(0xFFE5E5E5);
// //
// //   /// Input prefix / suffix icons
// //   static const Color authInputIcon = Color(0xFFBFBFBF);
// //
// //   /// Placeholder text in auth fields
// //   static const Color authPlaceholder = Color(0xFFCCCCCC);
// //
// //   /// Divider on auth card
// //   static const Color authDivider = Color(0xFFEBEBEB);
// //
// //   /// Social button label color
// //   static const Color authSocialLabel = Color(0xFF3A3A3A);
// //
// //   /// Filled primary CTA on auth card (dark pill)
// //   static const Color authPrimaryButton = Color(0xFF0A0A0A);
// // }
//
// // lib/config/theme/app_colors.dart
// import 'package:flutter/material.dart';
//
// class AppColors {
//   // Background & Surfaces
//   static const Color background =
//       Color(0xFFF8F9FA); // Very light grey (main screen bg)
//   static const Color surface = Colors.white; // White for cards, headers, modals
//
//   // Text colors
//   static const Color textPrimary =
//       Color(0xFF424242); // Dark grey (headings, main text)
//   static const Color textSecondary =
//       Color(0xFF757575); // Medium grey (subtext, descriptions)
//   static const Color textHint =
//       Color(0xFFBDBDBD); // Light grey (hint text, time stamps)
//
//   // Borders & Dividers
//   static const Color borderLight =
//       Color(0xFFE0E0E0); // Light grey border (cards, inputs)
//   static const Color divider = Color(0xFFF0F0F0); // Very light divider line
//
//   // Icons & Icon backgrounds
//   static const Color iconBg =
//       Color(0xFFF5F5F5); // Light grey circle behind icons
//   static const Color iconColor = Color(0xFF9E9E9E); // Grey icons
//
//   // Shadows
//   static const Color shadowLight =
//       Color(0x1A000000); // 10% opacity black (subtle shadow)
//
//   // Accent / Status (used rarely, e.g. liked heart)
//   static const Color accentRed =
//       Color(0xFFE57373); // Soft red for liked outfits
// }

import 'package:flutter/material.dart';

class AppColors {
  static const surface = Colors.white;

  static const textPrimary = Color(0xFF111111);
  static const textSecondary = Color(0xFF6B6B6B);
  static const textHint = Color(0xFFBDBDBD);

  static const border = Color(0xFFEAEAEA);

  static const iconBg = Color(0xFFF2F2F2);
  static const iconColor = Color(0xFF8E8E93);

  static const shadow = Color(0x14000000); // subtle shadow

  // ========== DEEP SLATE BLUE (Primary Trust) ==========
  // Base: #2C3E50
  static const Color slateBlue50 = Color(0xFFE9ECEF);  // very light
  static const Color slateBlue100 = Color(0xFFCED4DA);
  static const Color slateBlue200 = Color(0xFFADB5BD);
  static const Color slateBlue300 = Color(0xFF6C757D);
  static const Color slateBlue400 = Color(0xFF495057);
  static const Color slateBlue500 = Color(0xFF2C3E50); // base
  static const Color slateBlue600 = Color(0xFF243342);
  static const Color slateBlue700 = Color(0xFF1D2834);
  static const Color slateBlue800 = Color(0xFF151E26);
  static const Color slateBlue900 = Color(0xFF0E1419);

  // ========== SOFT TEAL (Secondary / Confidence) ==========
  // Base: #3A7CA5
  static const Color softTeal50 = Color(0xFFE6F2F7);
  static const Color softTeal100 = Color(0xFFCCE5F0);
  static const Color softTeal200 = Color(0xFF99CBE0);
  static const Color softTeal300 = Color(0xFF66B0D1);
  static const Color softTeal400 = Color(0xFF4096BB);
  static const Color softTeal500 = Color(0xFF3A7CA5); // base
  static const Color softTeal600 = Color(0xFF2E6384);
  static const Color softTeal700 = Color(0xFF234A63);
  static const Color softTeal800 = Color(0xFF173242);
  static const Color softTeal900 = Color(0xFF0C1921);

  // ========== MUTED SAGE GREEN (Accent / Wellness) ==========
  // Base: #7DAA92
  static const Color sageGreen50 = Color(0xFFF2F6F4);
  static const Color sageGreen100 = Color(0xFFE5EDE9);
  static const Color sageGreen200 = Color(0xFFCCDBD3);
  static const Color sageGreen300 = Color(0xFFB2C9BD);
  static const Color sageGreen400 = Color(0xFF98B7A7);
  static const Color sageGreen500 = Color(0xFF7DAA92); // base
  static const Color sageGreen600 = Color(0xFF648875);
  static const Color sageGreen700 = Color(0xFF4B6658);
  static const Color sageGreen800 = Color(0xFF32443A);
  static const Color sageGreen900 = Color(0xFF19221D);

  // ========== SEMANTIC ALIASES (for easier use in your app) ==========
  static const Color primaryTrust = slateBlue500;
  static const Color primaryTrustDark = slateBlue700;
  static const Color primaryTrustLight = slateBlue200;

  static const Color confidenceAccent = softTeal500;
  static const Color confidenceAccentDark = softTeal700;
  static const Color background = Color(0xFF7EC4C4);
  static const Color confidenceAccentLight = softTeal200;

  static const Color wellnessAccent = sageGreen500;
  static const Color wellnessAccentDark = sageGreen700;
  static const Color wellnessAccentLight = sageGreen200;

  // Neutral backgrounds (using slate blue's lightest for calmness)
  static const Color backgroundLight = slateBlue50;
  static const Color backgroundCard = Colors.white;

  static const Color welcomeScreenColor = Color(0xFFFF5252);
}
