import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/vi_seal.dart';

class ReadyPage extends StatefulWidget {
  const ReadyPage({super.key});

  @override
  State<ReadyPage> createState() => _ReadyPageState();
}

class _ReadyPageState extends State<ReadyPage> {
  bool n = true, l = true, c = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: RadialGradient(center: Alignment(0, -0.5), radius: 1.2, colors: [Color(0xFF1A2463), Color(0xFF0C1543), Color(0xFF06091F)])),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
            child: Column(
              children: [
                Text('V · I', style: TextStyle(fontSize: 11, letterSpacing: 5, color: AppColors.gold.withValues(alpha: 0.85))),
                const SizedBox(height: 12),
                const ViSeal(size: 180),
                const SizedBox(height: 16),
                const Text('INDUCTED', style: TextStyle(fontSize: 9, letterSpacing: 3.2, color: AppColors.gold, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text("You're ready.", style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Text('Victus is composing your first outfit.', style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.65), fontStyle: FontStyle.italic)),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.gold.withValues(alpha: 0.2)),
                    color: Colors.white.withValues(alpha: 0.04),
                  ),
                  child: Column(
                    children: [
                      _perm('Notifications', 'Daily outfit & weather nudges', n, (v) => setState(() => n = v)),
                      Divider(height: 1, color: Colors.white.withValues(alpha: 0.05)),
                      _perm('Location', 'Weather-aware recommendations', l, (v) => setState(() => l = v)),
                      Divider(height: 1, color: Colors.white.withValues(alpha: 0.05)),
                      _perm('Calendar', 'Dress for your meetings & events', c, (v) => setState(() => c = v)),
                    ],
                  ),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () => context.go(AppRoutes.home),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.navy,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('ENTER VICTUS', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 2)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _perm(String title, String desc, bool on, ValueChanged<bool> set) {
    return SwitchListTile(
      value: on,
      onChanged: set,
      activeThumbColor: AppColors.gold,
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
      subtitle: Text(desc, style: TextStyle(color: Colors.white.withValues(alpha: 0.55), fontSize: 11)),
    );
  }
}
