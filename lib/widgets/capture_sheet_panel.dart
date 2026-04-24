import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CaptureSheetPanel extends StatelessWidget {
  const CaptureSheetPanel({
    super.key,
    required this.onClose,
    required this.onCamera,
    required this.onGallery,
    required this.onUrl,
  });

  final VoidCallback onClose;
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback onUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFCFBF7), Color(0xFFF5F2EA)],
        ),
      ),
      padding: EdgeInsets.fromLTRB(24, 16, 24, 20 + MediaQuery.paddingOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(color: const Color(0xFFD4D4DC), borderRadius: BorderRadius.circular(99)),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'ADD TO WARDROBE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9.5,
              letterSpacing: 2.8,
              fontWeight: FontWeight.bold,
              color: AppColors.navy.withValues(alpha: 0.45),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Three ways in.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, fontStyle: FontStyle.italic, color: AppColors.navy),
          ),
          const SizedBox(height: 20),
          _Option(
            title: 'TAKE PHOTO',
            subtitle: 'Use camera to capture a piece',
            icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
            goldIcon: true,
            onTap: onCamera,
          ),
          const SizedBox(height: 10),
          _Option(
            title: 'CHOOSE FROM PHOTOS',
            subtitle: 'Pick from your photo library',
            icon: const Icon(Icons.image_outlined, color: AppColors.gold, size: 20),
            goldIcon: false,
            onTap: onGallery,
          ),
          const SizedBox(height: 10),
          _Option(
            title: 'IMPORT FROM URL',
            subtitle: 'Paste a product link',
            icon: const Icon(Icons.link, color: AppColors.gold, size: 20),
            goldIcon: false,
            onTap: onUrl,
          ),
          const SizedBox(height: 16),
          TextButton(onPressed: onClose, child: const Text('CANCEL')),
        ],
      ),
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.goldIcon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Widget icon;
  final bool goldIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: goldIcon
                      ? const RadialGradient(
                          colors: [Color(0xFFFFF4CC), Color(0xFFFFD875), Color(0xFFE8B84A), Color(0xFFC9972A)],
                        )
                      : null,
                  color: goldIcon ? null : AppColors.navy,
                ),
                child: Center(child: icon),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.navy)),
                    Text(subtitle, style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: AppColors.slate)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFFB8BBD0)),
            ],
          ),
        ),
      ),
    );
  }
}
