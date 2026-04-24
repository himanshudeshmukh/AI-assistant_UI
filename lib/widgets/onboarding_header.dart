import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({
    super.key,
    required this.onBack,
    this.light = false,
  });

  final VoidCallback onBack;
  final bool light;

  @override
  Widget build(BuildContext context) {
    final fg = light ? Colors.white : AppColors.navy;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onBack,
          style: IconButton.styleFrom(
            backgroundColor: light ? Colors.white.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.85),
          ),
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 17, color: fg),
        ),
        Text(
          'V · I',
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 5,
            fontWeight: FontWeight.w600,
            color: light ? AppColors.gold.withValues(alpha: 0.85) : AppColors.navy.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(width: 40),
      ],
    );
  }
}

void popOrGo(BuildContext context, [String? fallback]) {
  if (context.canPop()) {
    context.pop();
  } else if (fallback != null) {
    context.go(fallback);
  }
}
