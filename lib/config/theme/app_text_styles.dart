/// [AppTextStyles] - Centralized text styling for consistent typography
///
/// Defines all text styles used across the application including fonts,
/// sizes, weights, and colors. This ensures consistency and makes it easy
/// to update typography globally.
///
/// Usage: AppTextStyles.headingLarge, AppTextStyles.bodyMedium, etc.
library;

import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Private constructor to prevent instantiation
  AppTextStyles._();

  // ==================== Heading Styles ====================
  /// Large heading - 28sp, bold weight 700
  /// Used for main screen titles
  static const TextStyle headingLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  /// Medium heading - 24sp, bold weight 600
  /// Used for section headers
  static const TextStyle headingMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  /// Small heading - 20sp, bold weight 600
  /// Used for form labels and secondary headers
  static const TextStyle headingSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  // ==================== Body Text Styles ====================
  /// Large body text - 16sp, regular weight 400
  /// Used for main body content and button text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  /// Medium body text - 14sp, regular weight 400
  /// Used for form input labels and standard text
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0.25,
  );

  /// Small body text - 12sp, regular weight 400
  /// Used for helper text, hints, and secondary information
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: 0.4,
  );

  // ==================== Button Text Styles ====================
  /// Button text - 16sp, bold weight 600
  /// Used for primary and secondary button labels
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.surfaceColor,
    letterSpacing: 0.5,
  );

  /// Small button text - 14sp, bold weight 600
  /// Used for small action buttons
  static const TextStyle buttonSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.surfaceColor,
    letterSpacing: 0.5,
  );

  // ==================== Link Styles ====================
  /// Link text - 14sp, medium weight 500
  /// Used for clickable text links
  static const TextStyle linkText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryOrange,
    letterSpacing: 0.25,
    decoration: TextDecoration.none,
  );

  /// Small link text - 12sp, medium weight 500
  static const TextStyle linkSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryOrange,
    letterSpacing: 0.2,
    decoration: TextDecoration.none,
  );

  // ==================== Form Input Styles ====================
  /// Input text style - 16sp, regular weight 400
  /// Used for text entered in form fields
  static const TextStyle inputText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  /// Input hint text style - 16sp, regular weight 400, secondary color
  static const TextStyle inputHint = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.placeholderColor,
    letterSpacing: 0.5,
  );

  /// Input label text style - 14sp, medium weight 500
  static const TextStyle inputLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.25,
  );

  // ==================== Error Styles ====================
  /// Error text - 12sp, regular weight 400, error color
  static const TextStyle errorText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.errorColor,
    letterSpacing: 0.4,
  );

  // ==================== Caption Styles ====================
  /// Caption text - 12sp, regular weight 400, secondary color
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: 0.4,
  );

  /// Overline text - 10sp, bold weight 600, uppercase
  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 1.5,
  );
}
