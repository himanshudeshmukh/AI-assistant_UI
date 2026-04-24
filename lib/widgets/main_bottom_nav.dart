import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/app_routes.dart';
import '../state/sheet_controller.dart';
import '../theme/app_colors.dart';
import 'orb_widget.dart';

class MainBottomNav extends StatelessWidget {
  const MainBottomNav({super.key, required this.currentPath});

  final String currentPath;

  bool _active(String path) => currentPath == path;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final inactive = Colors.white.withValues(alpha: 0.55);
    final iconSize = (w * 0.055).clamp(17.0, 22.0);

    return Container(
      margin: EdgeInsets.fromLTRB(w * 0.03, 0, w * 0.03, 0),
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 18),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [BoxShadow(color: AppColors.navy.withValues(alpha: 0.2), blurRadius: 24, offset: const Offset(0, -8))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _item(context, AppRoutes.home, Icons.home_rounded, 'HOME', iconSize, inactive),
          _item(context, AppRoutes.wardrobe, Icons.checkroom_outlined, 'WARDROBE', iconSize, inactive),
          Expanded(child: _assist(context, iconSize)),
          _item(context, AppRoutes.studio, Icons.auto_fix_high_outlined, 'STUDIO', iconSize, inactive),
          _item(context, AppRoutes.explorer, Icons.explore_outlined, 'EXPLORER', iconSize, inactive),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, String path, IconData icon, String label, double sz, Color inactive) {
    final on = _active(path);
    final c = on ? AppColors.gold : inactive;
    return Expanded(
      child: InkWell(
        onTap: () => context.go(path),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: sz, color: c),
              const SizedBox(height: 4),
              Text(label, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: c)),
              SizedBox(height: on ? 4 : 4),
              if (on) Container(width: 4, height: 4, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.gold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _assist(BuildContext context, double iconSize) {
    final orbSize = (iconSize * 2.5).clamp(48.0, 56.0);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: const Offset(0, -14),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => context.read<SheetController>().openOrbSheet(),
              child: OrbWidget(size: orbSize),
            ),
          ),
        ),
        Text('ASSIST', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.white.withValues(alpha: 0.55))),
        const SizedBox(height: 4),
      ],
    );
  }
}
