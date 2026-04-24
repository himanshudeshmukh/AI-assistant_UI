import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/orb_widget.dart';

class ConciergePage extends StatelessWidget {
  const ConciergePage({super.key});

  static const _items = [
    ('ONE', 'Dressed by an algorithm', 'that studies weather, hour, and occasion.'),
    ('TWO', 'A wardrobe that remembers', 'which pieces serve which moments.'),
    ('THREE', 'A private style intelligence', 'that learns how you like to be seen.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.darkRadial),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Column(
              children: [
                Text(
                  'V · I',
                  style: TextStyle(fontSize: 11, letterSpacing: 5, color: AppColors.gold.withValues(alpha: 0.85)),
                ),
                const SizedBox(height: 20),
                const OrbWidget(size: 104, pulse: true),
                const SizedBox(height: 24),
                const Text(
                  'YOUR CONCIERGE',
                  style: TextStyle(fontSize: 10, letterSpacing: 3.2, fontWeight: FontWeight.bold, color: AppColors.gold),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Three things we\npromise you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 34,
                    height: 1.05,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.separated(
                    itemCount: _items.length,
                    separatorBuilder: (_, i) => const SizedBox(height: 18),
                    itemBuilder: (_, i) {
                      final e = _items[i];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 44,
                            child: Text(
                              e.$1,
                              style: const TextStyle(
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                                color: AppColors.gold,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.$2,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    height: 1.15,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  e.$3,
                                  style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.6), fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () => context.go(AppRoutes.signUp),
                    borderRadius: BorderRadius.circular(12),
                    child: Ink(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        gradient: LinearGradient(colors: [Color(0xFFF2C96B), Color(0xFFE8B84A), Color(0xFFC9972A)]),
                      ),
                      child: const Center(
                        child: Text(
                          'CONTINUE',
                          style: TextStyle(
                            color: AppColors.navy,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 3.4,
                          ),
                        ),
                      ),
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
