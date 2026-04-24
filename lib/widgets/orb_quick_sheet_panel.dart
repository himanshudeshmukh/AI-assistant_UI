import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'orb_widget.dart';

class OrbQuickSheetPanel extends StatelessWidget {
  const OrbQuickSheetPanel({
    super.key,
    required this.onClose,
    required this.onCapture,
    required this.onStyleMe,
  });

  final VoidCallback onClose;
  final VoidCallback onCapture;
  final VoidCallback onStyleMe;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(onTap: onClose, child: Container(height: 12)),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFCFBF7), Color(0xFFF5F2EA)],
              ),
            ),
            padding: EdgeInsets.fromLTRB(24, 16, 24, 24 + MediaQuery.paddingOf(context).bottom),
            child: Column(
              children: [
                Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(color: const Color(0xFFD4D4DC), borderRadius: BorderRadius.circular(99)),
                ),
                const SizedBox(height: 20),
                const OrbWidget(size: 56, pulse: true),
                const SizedBox(height: 14),
                Text(
                  'How may I serve you?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontStyle: FontStyle.italic,
                    color: AppColors.navy,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'CHOOSE YOUR MOMENT',
                  style: TextStyle(
                    fontSize: 9.5,
                    letterSpacing: 2.8,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navy.withValues(alpha: 0.45),
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: _ActionCard(
                        light: true,
                        onTap: onCapture,
                        icon: const Icon(Icons.camera_alt, color: Colors.white, size: 22),
                        title: 'CAPTURE',
                        subtitle: 'Add a piece to\nyour wardrobe',
                        titleColor: AppColors.navy,
                        subtitleColor: AppColors.slate,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionCard(
                        light: false,
                        onTap: onStyleMe,
                        icon: const OrbWidget(size: 52, withGlow: false),
                        title: 'STYLE ME',
                        subtitle: 'Speak with your\nconcierge',
                        titleColor: AppColors.gold,
                        subtitleColor: Colors.white70,
                      ),
                    ),
                  ],
                ),
                TextButton(onPressed: onClose, child: const Text('DISMISS')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.light,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.titleColor,
    required this.subtitleColor,
  });

  final bool light;
  final VoidCallback onTap;
  final Widget icon;
  final String title;
  final String subtitle;
  final Color titleColor;
  final Color subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: light ? Colors.white : AppColors.navy,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              icon,
              const SizedBox(height: 12),
              Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.8, color: titleColor)),
              const SizedBox(height: 6),
              Text(subtitle, textAlign: TextAlign.center, style: TextStyle(fontSize: 10.5, fontStyle: FontStyle.italic, color: subtitleColor)),
            ],
          ),
        ),
      ),
    );
  }
}
