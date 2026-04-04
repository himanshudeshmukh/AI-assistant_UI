// /// lib/config/theme/app_theme.dart
// ///
// /// Complete theme configuration for the Authenticator app.
// /// Provides light and dark themes with yellow primary color.
// ///
//
// import 'package:flutter/material.dart';
// import 'app_colors.dart';
// import 'app_text_styles.dart';
//
// class AppTheme {
//   // Private constructor to prevent instantiation
//   AppTheme._();
//
//   // ============================================================================
//   // LIGHT THEME
//   // ============================================================================
//
//   /// Build light theme for the app
//   static ThemeData get lightTheme {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.light,
//
//       // Color scheme
//       colorScheme: AppColors.lightColorScheme,
//
//       // Primary colors
//       primaryColor: AppColors.primary,
//       primaryColorDark: AppColors.primaryDark,
//       primaryColorLight: AppColors.primaryLight,
//       scaffoldBackgroundColor: AppColors.background,
//
//       // ========================================================================
//       // APP BAR THEME
//       // ========================================================================
//       appBarTheme: AppBarTheme(
//         elevation: 0,
//         backgroundColor: AppColors.white,
//         foregroundColor: AppColors.textPrimary,
//         surfaceTintColor: AppColors.white,
//         centerTitle: true,
//         titleTextStyle: AppTextStyles.headlineLarge.copyWith(
//           color: AppColors.textPrimary,
//         ),
//         iconTheme: const IconThemeData(
//           color: AppColors.textPrimary,
//           size: 24,
//         ),
//         toolbarHeight: 56,
//       ),
//
//       // ========================================================================
//       // TEXT FIELD (INPUT DECORATION) THEME
//       // ========================================================================
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: AppColors.lightGray,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 14,
//         ),
//         isDense: false,
//
//         // Border styles
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(
//             color: AppColors.textHint,
//             width: 1,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(
//             color: AppColors.textHint,
//             width: 1,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(
//             color: AppColors.primary,
//             width: 2,
//           ),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(
//             color: AppColors.error,
//             width: 1,
//           ),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(
//             color: AppColors.error,
//             width: 2,
//           ),
//         ),
//         disabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(
//             color: AppColors.mediumGray,
//             width: 1,
//           ),
//         ),
//
//         // Text styles
//         hintStyle: AppTextStyles.inputHint,
//         labelStyle: AppTextStyles.inputLabel,
//         errorStyle: AppTextStyles.errorMessage.copyWith(height: 1.2),
//         helperStyle: AppTextStyles.bodySmall.copyWith(
//           color: AppColors.textSecondary,
//         ),
//
//         // Prefix/Suffix icon colors
//         prefixIconColor: AppColors.textSecondary,
//         suffixIconColor: AppColors.textSecondary,
//         prefixStyle: AppTextStyles.bodyMedium,
//         suffixStyle: AppTextStyles.bodyMedium,
//
//         // Counter style
//         counterStyle: AppTextStyles.bodySmall,
//
//         // Floated label behavior
//         floatingLabelBehavior: FloatingLabelBehavior.auto,
//       ),
//
//       // ========================================================================
//       // ELEVATED BUTTON THEME
//       // ========================================================================
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primary,
//           foregroundColor: AppColors.white,
//           disabledBackgroundColor: AppColors.mediumGray,
//           disabledForegroundColor: AppColors.white.withOpacity(0.5),
//           elevation: 2,
//           shadowColor: AppColors.primary.withOpacity(0.3),
//           padding: const EdgeInsets.symmetric(
//             horizontal: 24,
//             vertical: 14,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           textStyle: AppTextStyles.primaryButton,
//           animationDuration: const Duration(milliseconds: 200),
//         ),
//       ),
//
//       // ========================================================================
//       // OUTLINED BUTTON THEME
//       // ========================================================================
//       outlinedButtonTheme: OutlinedButtonThemeData(
//         style: OutlinedButton.styleFrom(
//           foregroundColor: AppColors.primary,
//           side: const BorderSide(
//             color: AppColors.primary,
//             width: 2,
//           ),
//           disabledForegroundColor: AppColors.mediumGray,
//           padding: const EdgeInsets.symmetric(
//             horizontal: 24,
//             vertical: 14,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           textStyle: AppTextStyles.secondaryButton,
//           animationDuration: const Duration(milliseconds: 200),
//         ),
//       ),
//
//       // ========================================================================
//       // TEXT BUTTON THEME
//       // ========================================================================
//       textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(
//           foregroundColor: AppColors.primary,
//           padding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 8,
//           ),
//           textStyle: AppTextStyles.labelLarge,
//           animationDuration: const Duration(milliseconds: 200),
//         ),
//       ),
//
//       // ========================================================================
//       // FLOATING ACTION BUTTON THEME
//       // ========================================================================
//       floatingActionButtonTheme: FloatingActionButtonThemeData(
//         backgroundColor: AppColors.primary,
//         foregroundColor: AppColors.white,
//         elevation: 4,
//         focusElevation: 8,
//         hoverElevation: 8,
//         splashColor: AppColors.white.withOpacity(0.5),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(16)),
//         ),
//       ),
//
//       // ========================================================================
//       // CHECKBOX THEME
//       // ========================================================================
//       checkboxTheme: CheckboxThemeData(
//         fillColor: MaterialStateProperty.resolveWith((states) {
//           if (states.contains(MaterialState.selected)) {
//             return AppColors.primary;
//           }
//           return AppColors.lightGray;
//         }),
//         checkColor: MaterialStateProperty.all(AppColors.white),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(4),
//         ),
//       ),
//
//       // ========================================================================
//       // RADIO BUTTON THEME
//       // ========================================================================
//       radioTheme: RadioThemeData(
//         fillColor: MaterialStateProperty.resolveWith((states) {
//           if (states.contains(MaterialState.selected)) {
//             return AppColors.primary;
//           }
//           return AppColors.textHint;
//         }),
//       ),
//
//       // ========================================================================
//       // SWITCH THEME
//       // ========================================================================
//       switchTheme: SwitchThemeData(
//         thumbColor: MaterialStateProperty.resolveWith((states) {
//           if (states.contains(MaterialState.selected)) {
//             return AppColors.white;
//           }
//           return AppColors.mediumGray;
//         }),
//         trackColor: MaterialStateProperty.resolveWith((states) {
//           if (states.contains(MaterialState.selected)) {
//             return AppColors.primary;
//           }
//           return AppColors.lightGray;
//         }),
//       ),
//
//       // ========================================================================
//       // DIALOG THEME
//       // ========================================================================
//       dialogTheme: DialogThemeData(
//         backgroundColor: AppColors.surface,
//         elevation: 8,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         titleTextStyle: AppTextStyles.headlineMedium,
//         contentTextStyle: AppTextStyles.bodyMedium,
//       ),
//
//       // ========================================================================
//       // SNACK BAR THEME
//       // ========================================================================
//       snackBarTheme: SnackBarThemeData(
//         backgroundColor: AppColors.darkGray,
//         contentTextStyle: AppTextStyles.bodyMedium.copyWith(
//           color: AppColors.white,
//         ),
//         actionTextColor: AppColors.primary,
//         elevation: 4,
//         insetPadding: const EdgeInsets.all(16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         behavior: SnackBarBehavior.floating,
//       ),
//
//       // ========================================================================
//       // CARD THEME
//       // ========================================================================
//       cardTheme: CardThemeData(
//         color: AppColors.surface,
//         elevation: 2,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         margin: EdgeInsets.zero,
//         surfaceTintColor: AppColors.primary.withOpacity(0.05),
//       ),
//
//       // ========================================================================
//       // DIVIDER THEME
//       // ========================================================================
//       dividerTheme: const DividerThemeData(
//         color: AppColors.lightGray,
//         thickness: 1,
//         space: 16,
//       ),
//
//       // ========================================================================
//       // CHIP THEME
//       // ========================================================================
//       chipTheme: ChipThemeData(
//         backgroundColor: AppColors.primaryVeryLight,
//         selectedColor: AppColors.primary,
//         disabledColor: AppColors.lightGray,
//         labelPadding: const EdgeInsets.symmetric(horizontal: 12),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         labelStyle: AppTextStyles.labelMedium,
//         secondaryLabelStyle: AppTextStyles.labelMedium.copyWith(
//           color: AppColors.white,
//         ),
//         brightness: Brightness.light,
//         elevation: 2,
//       ),
//
//       // ========================================================================
//       // BOTTOM SHEET THEME
//       // ========================================================================
//       bottomSheetTheme: const BottomSheetThemeData(
//         backgroundColor: AppColors.surface,
//         elevation: 8,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         modalBackgroundColor: AppColors.surface,
//         modalElevation: 8,
//       ),
//
//       // ========================================================================
//       // NAVIGATION RAIL THEME
//       // ========================================================================
//       navigationRailTheme: NavigationRailThemeData(
//         backgroundColor: AppColors.white,
//         elevation: 2,
//         selectedIconTheme: const IconThemeData(
//           color: AppColors.primary,
//           size: 24,
//         ),
//         unselectedIconTheme: const IconThemeData(
//           color: AppColors.textSecondary,
//           size: 24,
//         ),
//         selectedLabelTextStyle: AppTextStyles.labelMedium.copyWith(
//           color: AppColors.primary,
//         ),
//         unselectedLabelTextStyle: AppTextStyles.labelMedium.copyWith(
//           color: AppColors.textSecondary,
//         ),
//       ),
//
//       // ========================================================================
//       // BOTTOM NAVIGATION BAR THEME
//       // ========================================================================
//       bottomNavigationBarTheme: BottomNavigationBarThemeData(
//         backgroundColor: AppColors.white,
//         elevation: 8,
//         selectedItemColor: AppColors.primary,
//         unselectedItemColor: AppColors.textSecondary,
//         selectedLabelStyle: AppTextStyles.labelSmall,
//         unselectedLabelStyle: AppTextStyles.labelSmall,
//       ),
//
//       // ========================================================================
//       // PROGRESS INDICATOR THEME
//       // ========================================================================
//       progressIndicatorTheme: const ProgressIndicatorThemeData(
//         color: AppColors.primary,
//         linearMinHeight: 4,
//         circularTrackColor: AppColors.lightGray,
//       ),
//
//       // ========================================================================
//       // TOOLTIP THEME
//       // ========================================================================
//       tooltipTheme: TooltipThemeData(
//         decoration: BoxDecoration(
//           color: AppColors.darkGray,
//           borderRadius: BorderRadius.circular(6),
//         ),
//         textStyle: AppTextStyles.bodySmall.copyWith(
//           color: AppColors.white,
//         ),
//         showDuration: const Duration(seconds: 3),
//       ),
//
//       // ========================================================================
//       // TEXT THEME
//       // ========================================================================
//       textTheme: TextTheme(
//         displayLarge: AppTextStyles.displayLarge,
//         displayMedium: AppTextStyles.displayMedium,
//         displaySmall: AppTextStyles.displaySmall,
//         headlineLarge: AppTextStyles.headlineLarge,
//         headlineMedium: AppTextStyles.headlineMedium,
//         headlineSmall: AppTextStyles.headlineSmall,
//         titleLarge: AppTextStyles.titleLarge,
//         titleMedium: AppTextStyles.titleMedium,
//         titleSmall: AppTextStyles.titleSmall,
//         bodyLarge: AppTextStyles.bodyLarge,
//         bodyMedium: AppTextStyles.bodyMedium,
//         bodySmall: AppTextStyles.bodySmall,
//         labelLarge: AppTextStyles.labelLarge,
//         labelMedium: AppTextStyles.labelMedium,
//         labelSmall: AppTextStyles.labelSmall,
//       ),
//
//       // ========================================================================
//       // EXTENSION COLORS
//       // ========================================================================
//       extensions: <ThemeExtension<dynamic>>[],
//
//       // Other properties
//       pageTransitionsTheme: const PageTransitionsTheme(
//         builders: <TargetPlatform, PageTransitionsBuilder>{
//           TargetPlatform.android: ZoomPageTransitionsBuilder(),
//           TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
//           TargetPlatform.linux: ZoomPageTransitionsBuilder(),
//           TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
//           TargetPlatform.windows: ZoomPageTransitionsBuilder(),
//         },
//       ),
//     );
//   }
//
//   // ============================================================================
//   // DARK THEME
//   // ============================================================================
//
//   /// Build dark theme for the app
//   static ThemeData get darkTheme {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.dark,
//       colorScheme: ColorScheme.dark(
//         primary: AppColors.primary,
//         onPrimary: AppColors.black,
//         primaryContainer: AppColors.primaryDark,
//         onPrimaryContainer: AppColors.primaryLight,
//         secondary: AppColors.secondary,
//         onSecondary: AppColors.black,
//         secondaryContainer: AppColors.secondaryDark,
//         onSecondaryContainer: AppColors.secondaryLight,
//         surface: const Color(0xFF1F1F1F),
//         onSurface: AppColors.white,
//         error: AppColors.error,
//         onError: AppColors.white,
//       ),
//       primaryColor: AppColors.primary,
//       scaffoldBackgroundColor: const Color(0xFF121212),
//       textTheme: TextTheme(
//         displayLarge: AppTextStyles.displayLarge.copyWith(
//           color: AppColors.white,
//         ),
//         displayMedium: AppTextStyles.displayMedium.copyWith(
//           color: AppColors.white,
//         ),
//         displaySmall: AppTextStyles.displaySmall.copyWith(
//           color: AppColors.white,
//         ),
//         headlineLarge: AppTextStyles.headlineLarge.copyWith(
//           color: AppColors.white,
//         ),
//         headlineMedium: AppTextStyles.headlineMedium.copyWith(
//           color: AppColors.white,
//         ),
//         headlineSmall: AppTextStyles.headlineSmall.copyWith(
//           color: AppColors.white,
//         ),
//         titleLarge: AppTextStyles.titleLarge.copyWith(
//           color: AppColors.white,
//         ),
//         titleMedium: AppTextStyles.titleMedium.copyWith(
//           color: AppColors.white,
//         ),
//         titleSmall: AppTextStyles.titleSmall.copyWith(
//           color: AppColors.white.withOpacity(0.7),
//         ),
//         bodyLarge: AppTextStyles.bodyLarge.copyWith(
//           color: AppColors.white,
//         ),
//         bodyMedium: AppTextStyles.bodyMedium.copyWith(
//           color: AppColors.white.withOpacity(0.7),
//         ),
//         bodySmall: AppTextStyles.bodySmall.copyWith(
//           color: AppColors.white.withOpacity(0.6),
//         ),
//       ),
//     );
//   }
// }
//
// // ============================================================================
// // EXTENSION: ThemeData Extensions
// // ============================================================================
//
// /// Extension methods for ThemeData
// extension ThemeDataExtensions on ThemeData {
//   /// Check if theme is dark
//   bool get isDark => brightness == Brightness.dark;
//
//   /// Check if theme is light
//   bool get isLight => brightness == Brightness.light;
// }

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    const textTheme = TextTheme(
      titleLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: 9,
        fontWeight: FontWeight.w500,
        color: AppColors.authHeroAccent,
        letterSpacing: 1.2,
      ),
    );
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.authHeroAccent,
      colorScheme: const ColorScheme.light(
        surface: AppColors.authHeroAccent,
        primary: AppColors.authHeroAccent,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: textTheme,
      dividerColor: AppColors.backgroundColor,
      splashFactory: NoSplash.splashFactory,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.authCardSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.inputBorderColor),
        ),
        hintStyle: const TextStyle(
          fontSize: 12,
          color: AppColors.authInputBorder,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }
}
