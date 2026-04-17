/* ===================== BACKGROUND ===================== */

import 'package:Kaivon/config/theme/app_colors.dart';
import 'package:Kaivon/presentation/screens/auth/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final randomSeed = 12;

    double stepY = size.height * 0.06;

    for (double y = 0; y < size.height; y += stepY) {
      final path = Path();

      path.moveTo(0, y);

      double x1 = size.width * 0.25;
      double x2 = size.width * 0.55;
      double x3 = size.width * 0.85;

      // 🔥 add slight randomness feel using sine wave distortion
      double wave1 = 15 * (y % 3 == 0 ? 1 : -1);
      double wave2 = 25 * (y % 2 == 0 ? 1 : -1);

      path.cubicTo(
        x1, y + wave1,
        x2, y - wave2,
        size.width, y + wave1,
      );

      canvas.drawPath(path, paint);
    }

    /// 🔥 extra diagonal floating waves
    for (double i = 0; i < size.width; i += size.width * 0.2) {
      final path = Path();

      path.moveTo(i, 0);

      path.quadraticBezierTo(
        i + 40,
        size.height * 0.3,
        i - 20,
        size.height * 0.6,
      );

      path.quadraticBezierTo(
        i + 30,
        size.height * 0.8,
        i,
        size.height,
      );

      canvas.drawPath(
        path,
        paint..color = Colors.white.withOpacity(0.05),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
/* ===================== WAVE CARD ===================== */

class BottomWaveCard extends StatelessWidget {
  final double height;

  const BottomWaveCard({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: height,
        width: double.infinity,

        /// 🔥 SOFT MATCHED COLOR (NOT PURE WHITE)
        color: const Color(0xFFF7FAFA),

        /// 🔥 GRADIENT BLEND TO REMOVE DIVIDE LINE
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.0),
                Colors.white.withOpacity(0.4),
                Colors.white,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start slightly down from top-left
    path.lineTo(0, size.height * 0.20);

    // ONE smooth wave (1 peak + 1 dip)
    path.cubicTo(
      size.width * 0.25, size.height * 0.12, // upward curve (crest)
      size.width * 0.60, size.height * 0.45, // downward curve (dip)
      size.width, size.height * 0.28,        // end right
    );

    // Close shape
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}



class InputField extends StatelessWidget {
  final String hint;
  final double width;
  final bool isPassword;

  const InputField({
    super.key,
    required this.hint,
    required this.width,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      /// 🔥 HEIGHT + SPACING
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),

      decoration: BoxDecoration(
        color: Colors.grey.shade100, // light gray background

        /// 🔥 CIRCULAR BORDER
        borderRadius: BorderRadius.circular(width * 0.03),

        /// 🔥 SOFT SHADOW
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: TextField(
        obscureText: isPassword,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),

        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),

          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 8,
          ),
        ),
      ),
    );
  }
}

class TopContent extends StatelessWidget {
  final double height;
  final double width;
  final bool showText;

  const TopContent({
    super.key,
    required this.height,
    required this.width,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          /// 🔵 BASE COLOR
          Container(
            color: AppColors.background,
          ),

          /// 🌈 FLOATING BLUR BLOBS
          Positioned(
            top: -height * 0.1,
            left: -width * 0.2,
            child: _blob(AppColors.softTeal800.withOpacity(0.4), width * 0.6),
          ),

          Positioned(
            top: height * 0.04,
            right: -width * 0.25,
            child: _blob(AppColors.softTeal800.withOpacity(0.5), width * 0.5),
          ),

          Positioned(
            bottom: -height * 0.15,
            left: width * 0.2,
            child: _blob(AppColors.softTeal800.withOpacity(0.6), width * 0.7),
          ),

          /// 🌫 GRADIENT OVERLAY (DEPTH)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.08),
                  Colors.transparent,
                  Colors.black.withOpacity(0.08),
                ],
              ),
            ),
          ),

          /// ✨ TEXT
          if (showText)
            Center(
              child: Text(
                "Kaivon",
                style: GoogleFonts.kaushanScript(
                  fontSize: width * 0.18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// 🔵 BLOBS BUILDER
  Widget _blob(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 80,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }
}