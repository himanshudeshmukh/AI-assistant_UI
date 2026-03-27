import 'package:flutter/material.dart';
import 'package:profiler/presentation/screens/auth/login_screen.dart';
import 'package:profiler/presentation/screens/navigation/main_navigation.dart';
import 'config/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WardrobeApp());
}

class WardrobeApp extends StatelessWidget {
  const WardrobeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // home: const MainNavigation(),
      home: LoginScreen()
    );
  }
}