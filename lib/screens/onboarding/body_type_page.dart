import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/onboarding_header.dart';

class BodyTypePage extends StatefulWidget {
  const BodyTypePage({super.key});

  @override
  State<BodyTypePage> createState() => _BodyTypePageState();
}

class _BodyTypePageState extends State<BodyTypePage> {
  String? _sel;
  static const _opts = [('slim', 'Slim'), ('athletic', 'Athletic'), ('average', 'Average'), ('broad', 'Broad'), ('pns', 'Prefer not to say')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.creamGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OnboardingHeader(onBack: () => context.go(AppRoutes.gender)),
                const SizedBox(height: 20),
                Text('STEP 04 · PROFILE', style: TextStyle(fontSize: 9, letterSpacing: 3.2, color: AppColors.warmLabel.withValues(alpha: 0.95), fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Your\nproportions.', style: TextStyle(fontSize: 34, height: 1.05, fontStyle: FontStyle.italic, color: AppColors.navy)),
                const SizedBox(height: 24),
                ..._opts.map((e) {
                  final on = _sel == e.$1;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Material(
                      color: on ? AppColors.navy : Colors.white.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        onTap: () => setState(() => _sel = e.$1),
                        borderRadius: BorderRadius.circular(14),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                          child: Text(e.$2, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: on ? Colors.white : AppColors.navy)),
                        ),
                      ),
                    ),
                  );
                }),
                const Spacer(),
                FilledButton(
                  onPressed: _sel != null ? () => context.go(AppRoutes.upload) : null,
                  style: FilledButton.styleFrom(backgroundColor: AppColors.navy, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(48)),
                  child: const Text('CONTINUE'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
