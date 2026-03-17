/// [main.dart] - Application entry point
///
/// Configures the Flutter app with:
/// - Material theme using custom colors and typography
/// - Navigation routes
/// - Global error handling
/// - Root screen setup


import 'package:flutter/material.dart';
import 'package:profiler/presentation/screens/auth/login_screen.dart';
import 'package:profiler/presentation/screens/auth/signup_screen.dart';
import 'package:profiler/presentation/screens/home/home_screen.dart';
import 'package:profiler/presentation/screens/splash_screen.dart';
import 'config/theme/app_colors.dart';
import 'config/theme/app_dimensions.dart';
import 'config/theme/app_text_styles.dart';


void main() async {
  // Initialize any required services here
  // Example:
  // - Firebase initialization
  // - Local storage setup
  // - Analytics initialization

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

/// Main application widget
///
/// Configures Material theme and routes
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ==================== Branding ====================
      title: 'Genie.ai',

      // ==================== Theme Configuration ====================
      theme: ThemeData(
        // ========== Color Scheme ==========
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryOrange,
          brightness: Brightness.light,
        ),

        // ========== AppBar Theme ==========
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundColor,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: AppTextStyles.headingMedium,
        ),

        // ========== Text Theme ==========
        textTheme: const TextTheme(
          displayLarge: AppTextStyles.headingLarge,
          displayMedium: AppTextStyles.headingMedium,
          displaySmall: AppTextStyles.headingSmall,
          headlineMedium: AppTextStyles.headingMedium,
          headlineSmall: AppTextStyles.headingSmall,
          titleLarge: AppTextStyles.bodyLarge,
          titleMedium: AppTextStyles.bodyMedium,
          titleSmall: AppTextStyles.bodySmall,
          bodyLarge: AppTextStyles.bodyLarge,
          bodyMedium: AppTextStyles.bodyMedium,
          bodySmall: AppTextStyles.bodySmall,
          labelLarge: AppTextStyles.buttonLarge,
          labelMedium: AppTextStyles.buttonSmall,
        ),

        // ========== Input Decoration Theme ==========
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.inputPaddingHorizontal,
            vertical: AppDimensions.inputPaddingVertical,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusM,
            ),
            borderSide: const BorderSide(
              color: AppColors.inputBorderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusM,
            ),
            borderSide: const BorderSide(
              color: AppColors.inputBorderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusM,
            ),
            borderSide: const BorderSide(
              color: AppColors.primaryOrange,
              width: 2,
            ),
          ),
          hintStyle: AppTextStyles.inputHint,
          labelStyle: AppTextStyles.inputLabel,
          errorStyle: AppTextStyles.errorText,
        ),

        // ========== Button Theme ==========
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryOrange,
            foregroundColor: AppColors.surfaceColor,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.buttonPaddingHorizontal,
              vertical: AppDimensions.buttonPaddingVertical,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.buttonBorderRadius,
              ),
            ),
          ),
        ),

        // ========== Other Themes ==========
        scaffoldBackgroundColor: AppColors.backgroundColor,
        dividerColor: AppColors.dividerColor,
        dividerTheme: const DividerThemeData(
          color: AppColors.dividerColor,
          thickness: AppDimensions.dividerThickness,
        ),
      ),

      // ==================== Routes ====================
      home: const LoginScreen(),
      routes: {
        '/splash': (context) => const SplashScreenRobot(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        // TODO: Add more routes
        '/home': (context) => const HomeScreen(),
        // '/forgot-password': (context) => const ForgotPasswordScreen(),
      },

      // ==================== Error Handling ====================
      builder: (context, child) {
        // Wrap entire app with custom error handling if needed
        return child ?? const SizedBox.shrink();
      },

      // ==================== Debug Banner ====================
      debugShowCheckedModeBanner: false,
    );
  }
}

