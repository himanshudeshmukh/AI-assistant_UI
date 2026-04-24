import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/orb_widget.dart';

class AiAssistPage extends StatelessWidget {
  const AiAssistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.paddingOf(context);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.darkRadial),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, pad.top + 24, 20, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Your Concierge', textAlign: TextAlign.center, style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic, color: Colors.white)),
            const SizedBox(height: 8),
            const Text('IN SESSION', textAlign: TextAlign.center, style: TextStyle(fontSize: 9, letterSpacing: 2.4, color: AppColors.gold, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Center(child: OrbWidget(size: 72, pulse: true)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.06),
                borderRadius: const BorderRadius.only(topRight: Radius.circular(14), bottomRight: Radius.circular(14), bottomLeft: Radius.circular(14)),
                border: const Border(left: BorderSide(color: AppColors.gold, width: 2)),
              ),
              child: const Text(
                'Good evening, Himanshu. I see a crisp night ahead — how may I style you?',
                style: TextStyle(color: Colors.white, fontSize: 14, fontStyle: FontStyle.italic, height: 1.4),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.all(12),
                constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.78),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2463),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomLeft: Radius.circular(16), bottomRight: Radius.circular(4)),
                  border: Border.all(color: AppColors.gold.withValues(alpha: 0.25)),
                ),
                child: const Text('Business dinner at 8 tonight. Help me look sharp.', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
