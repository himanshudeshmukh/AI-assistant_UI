import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class ExplorerPage extends StatelessWidget {
  const ExplorerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.paddingOf(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(20, pad.top + 48, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('DISCOVER', style: TextStyle(fontSize: 9, letterSpacing: 2.8, color: AppColors.warmLabel.withValues(alpha: 0.95), fontWeight: FontWeight.bold)),
          const Text('Explorer', style: TextStyle(fontSize: 32, fontStyle: FontStyle.italic, color: AppColors.navy, height: 1.1)),
          const Spacer(),
          Center(
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
                    boxShadow: [BoxShadow(color: AppColors.gold.withValues(alpha: 0.12), blurRadius: 20)],
                  ),
                  child: const Icon(Icons.explore, size: 32, color: AppColors.goldDark),
                ),
                const SizedBox(height: 20),
                const Text('COMING SOON', style: TextStyle(fontSize: 9, letterSpacing: 3.2, color: AppColors.warmLabel, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text('A curated world of style.', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic, color: AppColors.navy)),
                const SizedBox(height: 8),
                Text(
                  'Trending looks, editorial stories, and pieces from makers worth knowing.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: AppColors.navy.withValues(alpha: 0.6), fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
