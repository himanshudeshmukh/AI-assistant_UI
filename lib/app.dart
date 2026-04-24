import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_routes.dart';
import 'router/app_router.dart';
import 'state/sheet_controller.dart';
import 'theme/app_colors.dart';
import 'widgets/capture_sheet_panel.dart';
import 'widgets/orb_quick_sheet_panel.dart';

class VictusApp extends StatelessWidget {
  const VictusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SheetController(),
      child: Consumer<SheetController>(
        builder: (context, sheet, _) {
          return MaterialApp.router(
            title: 'Victus One',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.navy, brightness: Brightness.light),
            ),
            routerConfig: victusRouter,
            builder: (context, child) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  child ?? const SizedBox.shrink(),
                  if (sheet.orbSheetOpen)
                    Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: sheet.closeOrbSheet,
                            child: ColoredBox(color: const Color(0xFF0A1133).withValues(alpha: 0.75)),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: OrbQuickSheetPanel(
                            onClose: sheet.closeOrbSheet,
                            onCapture: () {
                              sheet.closeOrbSheet();
                              Future.delayed(const Duration(milliseconds: 220), () {
                                if (!context.mounted) return;
                                context.read<SheetController>().openCaptureSheet();
                              });
                            },
                            onStyleMe: () {
                              sheet.closeOrbSheet();
                              Future.delayed(const Duration(milliseconds: 180), () {
                                victusRouter.go(AppRoutes.assist);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  if (sheet.captureSheetOpen)
                    Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: sheet.closeCaptureSheet,
                            child: ColoredBox(color: const Color(0xFF0A1133).withValues(alpha: 0.85)),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: CaptureSheetPanel(
                            onClose: sheet.closeCaptureSheet,
                            onCamera: sheet.closeCaptureSheet,
                            onGallery: sheet.closeCaptureSheet,
                            onUrl: sheet.closeCaptureSheet,
                          ),
                        ),
                      ],
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
