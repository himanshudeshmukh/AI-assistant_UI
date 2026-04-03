import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';

/// Dark full-width CTA used on Victus-style auth cards.
class AuthHeroPrimaryButton extends StatelessWidget {
  const AuthHeroPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;

    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          color: enabled
              ? AppColors.authPrimaryButton
              : AppColors.authTextMuted,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }
}
