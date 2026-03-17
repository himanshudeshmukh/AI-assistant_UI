/// [SplashScreenRobot] - Animated splash screen with AI robot coming out of mobile
///
/// Features:
/// - Smooth entrance animation
/// - AI robot pops out of mobile phone
/// - Holographic/tech effects
/// - App name reveals with animation
/// - Professional gradient background
/// - Loading indicator
///
/// Following: Animation best practices, Modern design, Tech aesthetic

import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';

/// Splash screen with animated AI robot coming out of mobile
///
/// Shows beautiful entrance animation with:
/// - Robot character animation
/// - Mobile phone placeholder
/// - Tech effects and hologram
/// - App branding
/// - Loading indicator
class SplashScreenRobot extends StatefulWidget {
  const SplashScreenRobot({Key? key}) : super(key: key);

  @override
  State<SplashScreenRobot> createState() => _SplashScreenRobotState();
}

class _SplashScreenRobotState extends State<SplashScreenRobot>
    with TickerProviderStateMixin {
  // ==================== Animation Controllers ====================
  late AnimationController _robotController;
  late AnimationController _glitchController;
  late AnimationController _textController;
  late AnimationController _dotsController;

  // ==================== Animations ====================
  late Animation<Offset> _robotPosition;
  late Animation<double> _robotOpacity;
  late Animation<double> _robotScale;
  late Animation<double> _glitchOpacity;
  late Animation<double> _textOpacity;

  // ==================== Lifecycle ====================
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _navigateHome();
  }

  /// Initialize all animations
  void _initializeAnimations() {
    // Robot pop animation
    _robotController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Robot position (comes from left side of screen)
    _robotPosition = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _robotController, curve: Curves.easeOut));

    // Robot opacity
    _robotOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _robotController, curve: Curves.easeIn),
    );

    // Robot scale for pop effect
    _robotScale = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(parent: _robotController, curve: Curves.easeOut),
    );

    // Glitch effect animation
    _glitchController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _glitchOpacity = Tween<double>(begin: 0.5, end: 0).animate(
      CurvedAnimation(parent: _glitchController, curve: Curves.easeOut),
    );

    // Text animation
    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    // Dots loading animation
    _dotsController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    // Start animations sequentially
    _robotController.forward();
    _glitchController.forward();

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        _textController.forward();
      }
    });
  }

  /// Navigate to home screen after splash
  void _navigateHome() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/app_shell');
      }
    });
  }

  // ==================== Build ====================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: _buildBody(),
    );
  }

  /// Builds the splash screen body
  Widget _buildBody() {
    return Stack(
      children: [
        // ==================== Background Gradient ====================
        _buildBackgroundGradient(),

        // ==================== Main Content ====================
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ==================== Robot Animation ====================
              _buildRobotAnimation(),

              SizedBox(height: MediaQuery.of(context).size.height * 0.08),

              // ==================== App Name ====================
              _buildAppName(),

              SizedBox(height: MediaQuery.of(context).size.height * 0.15),

              // ==================== Loading Dots ====================
              _buildLoadingDots(),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the background gradient with tech aesthetic
  Widget _buildBackgroundGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withOpacity(0.1),
            AppColors.primaryOrange.withOpacity(0.05),
            Colors.cyan.withOpacity(0.08),
          ],
        ),
      ),
    );
  }

  /// Builds the robot animation with mobile and effects
  Widget _buildRobotAnimation() {
    return SizedBox(
      height: 300,
      width: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ==================== Glitch Effect (Behind) ====================
          FadeTransition(
            opacity: _glitchOpacity,
            child: _buildGlitchEffect(),
          ),

          // ==================== Mobile Phone ====================
          _buildMobilePhone(),

          // ==================== Robot Character ====================
          SlideTransition(
            position: _robotPosition,
            child: ScaleTransition(
              scale: _robotScale,
              child: FadeTransition(
                opacity: _robotOpacity,
                child: _buildRobotCharacter(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the mobile phone illustration
  Widget _buildMobilePhone() {
    return CustomPaint(
      painter: MobilePhonePainter(),
      size: const Size(120, 200),
    );
  }

  /// Builds the AI robot character
  Widget _buildRobotCharacter() {
    return CustomPaint(
      painter: RobotPainter(),
      size: const Size(140, 160),
    );
  }

  /// Builds glitch/tech effect
  Widget _buildGlitchEffect() {
    return Stack(
      children: [
        // Horizontal glitch lines
        for (int i = 0; i < 5; i++)
          Positioned(
            top: (i * 40).toDouble(),
            left: 0,
            right: 0,
            child: Container(
              height: 20,
              color: AppColors.primaryOrange.withOpacity(0.1),
              transform: Matrix4.skewX(0.1),
            ),
          ),
      ],
    );
  }

  /// Builds the app name with animation
  Widget _buildAppName() {
    return FadeTransition(
      opacity: _textOpacity,
      child: Column(
        children: [
          Text(
            'Admiro.ai',
            style: AppTextStyles.headingLarge.copyWith(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your AI Fashion Assistant',
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 14,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the loading dots animation
  Widget _buildLoadingDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.2).animate(
              CurvedAnimation(
                parent: _dotsController,
                curve: Interval(
                  index * 0.33,
                  1,
                  curve: Curves.easeInOut,
                ),
              ),
            ),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryOrange,
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _robotController.dispose();
    _glitchController.dispose();
    _textController.dispose();
    _dotsController.dispose();
    super.dispose();
  }
}

// ==================== Custom Painters ====================

/// Paints the mobile phone illustration
class MobilePhonePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final phonePaint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.fill;

    final screenPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final framePaint = Paint()
      ..color = Colors.grey[800] ?? Colors.grey
      ..style = PaintingStyle.fill;

    // Phone body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.15, size.height * 0.1, size.width * 0.7, size.height * 0.8),
        const Radius.circular(20),
      ),
      phonePaint,
    );

    // Screen/display
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.2, size.height * 0.15, size.width * 0.6, size.height * 0.65),
        const Radius.circular(15),
      ),
      screenPaint,
    );

    // Screen frame highlight
    final framePath = Path();
    framePath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.2, size.height * 0.15, size.width * 0.6, size.height * 0.65),
        const Radius.circular(15),
      ),
    );

    final frameHighlight = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawPath(framePath, frameHighlight);

    // Notch
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.4, size.height * 0.1, size.width * 0.2, 15),
        const Radius.circular(8),
      ),
      phonePaint,
    );

    // Home button
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.88),
      6,
      frameHighlight,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// Paints the AI robot character
class RobotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final headPaint = Paint()
      ..color = Colors.cyan.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = Colors.cyan.withOpacity(0.9)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final glowPaint = Paint()
      ..color = Colors.cyan.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    // Head glow
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.25),
      35,
      glowPaint,
    );

    // Head (square/robot-like)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width / 2 - 25,
          size.height * 0.12,
          50,
          50,
        ),
        const Radius.circular(8),
      ),
      headPaint,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width / 2 - 25,
          size.height * 0.12,
          50,
          50,
        ),
        const Radius.circular(8),
      ),
      outlinePaint,
    );

    // Eyes (LED-like)
    final eyePaint = Paint()
      ..color = Colors.lime
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2 - 12, size.height * 0.25),
      6,
      eyePaint,
    );
    canvas.drawCircle(
      Offset(size.width / 2 + 12, size.height * 0.25),
      6,
      eyePaint,
    );

    // Antenna
    final antennaPaint = Paint()
      ..color = Colors.cyan
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(size.width / 2 - 15, size.height * 0.08),
      Offset(size.width / 2 - 20, size.height * 0.02),
      antennaPaint,
    );

    canvas.drawLine(
      Offset(size.width / 2 + 15, size.height * 0.08),
      Offset(size.width / 2 + 20, size.height * 0.02),
      antennaPaint,
    );

    // Body (rectangular, tech-like)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width / 2 - 30,
          size.height * 0.62,
          60,
          50,
        ),
        const Radius.circular(6),
      ),
      headPaint,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width / 2 - 30,
          size.height * 0.62,
          60,
          50,
        ),
        const Radius.circular(6),
      ),
      outlinePaint,
    );

    // Body panels/segments
    final panelPaint = Paint()
      ..color = Colors.cyan.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 3; i++) {
      canvas.drawRect(
        Rect.fromLTWH(
          size.width / 2 - 28,
          size.height * (0.65 + i * 0.12),
          56,
          10,
        ),
        panelPaint,
      );
    }

    // Arms
    final armPaint = Paint()
      ..color = Colors.cyan
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    // Left arm
    canvas.drawLine(
      Offset(size.width / 2 - 30, size.height * 0.75),
      Offset(size.width / 2 - 55, size.height * 0.70),
      armPaint,
    );

    // Right arm
    canvas.drawLine(
      Offset(size.width / 2 + 30, size.height * 0.75),
      Offset(size.width / 2 + 55, size.height * 0.70),
      armPaint,
    );

    // Hands (circles)
    final handPaint = Paint()
      ..color = Colors.cyan.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2 - 55, size.height * 0.70),
      5,
      handPaint,
    );
    canvas.drawCircle(
      Offset(size.width / 2 + 55, size.height * 0.70),
      5,
      handPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}