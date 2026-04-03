import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';

/// Divider + Google / Apple actions (uses same asset paths as `victus_one` pubspec).
class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({
    super.key,
    this.onGoogle,
    this.onApple,
  });

  final VoidCallback? onGoogle;
  final VoidCallback? onApple;

  static const String _googleAsset = 'assets/icons/google.png';
  static const String _appleAsset = 'assets/icons/apple.png';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.authDivider)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'OR',
                style: TextStyle(
                  color: AppColors.authTextMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const Expanded(child: Divider(color: AppColors.authDivider)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _SocialChip(
                label: 'Google',
                onTap: onGoogle,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    _googleAsset,
                    width: 20,
                    height: 20,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.g_mobiledata,
                      size: 22,
                      color: const Color(0xFF4285F4),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SocialChip(
                label: 'Apple',
                onTap: onApple,
                child: Image.asset(
                  _appleAsset,
                  width: 20,
                  height: 20,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.apple,
                    size: 22,
                    color: AppColors.authTextOnCard,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialChip extends StatelessWidget {
  const _SocialChip({
    required this.label,
    required this.child,
    this.onTap,
  });

  final String label;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.authInputBorder),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              child,
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.authSocialLabel,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
