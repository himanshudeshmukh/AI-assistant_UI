import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/onboarding_header.dart';

class FirstUploadPage extends StatelessWidget {
  const FirstUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.creamGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OnboardingHeader(onBack: () => context.go(AppRoutes.bodyType)),
                const SizedBox(height: 16),
                Text('STEP 05 · WARDROBE', style: TextStyle(fontSize: 9, letterSpacing: 3.2, color: AppColors.warmLabel.withValues(alpha: 0.95), fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Add your\nfirst pieces.', style: TextStyle(fontSize: 34, height: 1.05, fontStyle: FontStyle.italic, color: AppColors.navy)),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _slot('01'),
                    const SizedBox(width: 16),
                    _slot('02', primary: true),
                    const SizedBox(width: 16),
                    _slot('03'),
                  ],
                ),
                const Spacer(),
                Center(
                  child: Material(
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => context.go(AppRoutes.ready),
                      child: Ink(
                        width: 116,
                        height: 116,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            colors: [Color(0xFFFFF4CC), Color(0xFFFFD875), Color(0xFFE8B84A), Color(0xFFC9972A)],
                          ),
                          boxShadow: [BoxShadow(color: AppColors.gold.withValues(alpha: 0.45), blurRadius: 28)],
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 32),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(onPressed: () => context.go(AppRoutes.ready), child: const Text('Skip for now')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _slot(String label, {bool primary = false}) {
    return Container(
      width: 72,
      height: 96,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primary ? AppColors.navy.withValues(alpha: 0.08) : Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.navy.withValues(alpha: primary ? 0.35 : 0.15)),
      ),
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy.withValues(alpha: 0.5))),
    );
  }
}
