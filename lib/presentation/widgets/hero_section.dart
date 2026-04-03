import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';

/// Full-width hero header with solid dark background (no network images) and optional back control.
class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.height,
    required this.child,
    this.onBack,
  });

  final double height;
  final Widget child;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1A1A1A),
                  Colors.black,
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.authHeroBackground,
                  AppColors.authHeroBackground.withOpacity(0.75),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          if (onBack != null)
            Positioned(
              top: 48,
              left: 20,
              child: GestureDetector(
                onTap: onBack,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 32,
            left: 24,
            right: 24,
            child: child,
          ),
        ],
      ),
    );
  }
}
