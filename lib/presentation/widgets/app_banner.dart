import 'package:flutter/material.dart';

enum BannerType { success, error, info }

class AppBanner {
  static void show(
      BuildContext context, {
        required String message,
        BannerType type = BannerType.info,
        Duration duration = const Duration(seconds: 3),
      }) {
    final color = _getColor(type);
    final icon = _getIcon(type);

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    show(context, message: message, type: BannerType.success);
  }

  static void showError(BuildContext context, String message) {
    show(context, message: message, type: BannerType.error);
  }

  static void showInfo(BuildContext context, String message) {
    show(context, message: message, type: BannerType.info);
  }

  static Color _getColor(BannerType type) {
    switch (type) {
      case BannerType.success:
        return Colors.green;
      case BannerType.error:
        return Colors.red;
      case BannerType.info:
        return Colors.blue;
    }
  }

  static IconData _getIcon(BannerType type) {
    switch (type) {
      case BannerType.success:
        return Icons.check_circle;
      case BannerType.error:
        return Icons.error;
      case BannerType.info:
        return Icons.info;
    }
  }
}