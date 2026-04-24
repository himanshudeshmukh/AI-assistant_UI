import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes.dart';
import '../../theme/app_colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.shellGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
            child: Column(
              children: [
                Text(
                  'V · I',
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.navy.withValues(alpha: 0.7),
                  ),
                ),
                const Spacer(),
                Text(
                  'Welcome to\nVictus One.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 44,
                    height: 1.04,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'A private concierge for\nthe art of dressing well.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontStyle: FontStyle.italic,
                    color: AppColors.navy.withValues(alpha: 0.7),
                  ),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () => context.go(AppRoutes.concierge),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.navy,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('BEGIN', style: TextStyle(letterSpacing: 3.4, fontWeight: FontWeight.w800)),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => context.go(AppRoutes.login),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 12, color: AppColors.navy.withValues(alpha: 0.7), fontWeight: FontWeight.w600),
                      children: const [
                        TextSpan(text: 'Already a member? '),
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color: AppColors.navy),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
