


import 'dart:async';
import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import '../widgets/WavePainter.dart';
import 'auth/Auth_Service.dart';
import 'auth/login_screen.dart';
import 'navigation/main_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  String animatedText = "";

  @override
  void initState() {
    super.initState();

    /// FADE ANIMATION
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    /// TYPEWRITER ANIMATION
    _startTyping();

    /// NAVIGATION DELAY (optional)
    Future.delayed(const Duration(seconds: 4), () {
      // Navigate to home
    });
  }

  void _startTyping() async {
    final text = AppTextStyles.tagline;

    for (int i = 0; i <= text.length; i++) {
      await Future.delayed(const Duration(milliseconds: 40));
      setState(() {
        animatedText = text.substring(0, i);
      });
    }

    /// splash delay (animation time)
    await Future.delayed(const Duration(seconds: 2));

    final isLoggedIn = await AuthService.isLoggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigation()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }

  @override
  Widget build(BuildContext context) {
  return const Scaffold(
  body: Center(
  child: Text("ClosetGenie"), // your splash UI
  ),
  );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBg,

      body: Stack(
        children: [

          /// 🌊 WAVE BACKGROUND
          CustomPaint(
            size: Size.infinite,
            painter: WavePainter(),
          ),

          /// CONTENT
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  /// APP NAME
                  Text(
                    AppTextStyles.appName,
                    style: AppTextStyles.title,

                  ),

                  const SizedBox(height: 12),

                  /// TAGLINE WITH 🚀
                  Text(
                    "$animatedText 🚀",
                    style: AppTextStyles.subtitle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}