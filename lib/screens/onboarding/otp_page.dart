import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/onboarding_header.dart';
import '../../widgets/orb_widget.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _focus = List.generate(6, (_) => FocusNode());
  int _timer = 30;
  Timer? _t;

  @override
  void initState() {
    super.initState();
    _t = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_timer <= 0) return;
      setState(() => _timer--);
    });
  }

  @override
  void dispose() {
    _t?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focus) {
      f.dispose();
    }
    super.dispose();
  }

  bool get _filled => _controllers.every((c) => c.text.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.darkRadial),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
            child: Column(
              children: [
                OnboardingHeader(light: true, onBack: () => context.go(AppRoutes.signUp)),
                const SizedBox(height: 20),
                const OrbWidget(size: 56),
                const SizedBox(height: 20),
                const Text('VERIFY', style: TextStyle(fontSize: 9, letterSpacing: 3, color: AppColors.gold, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text(
                  'Enter the code\nwe texted you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontStyle: FontStyle.italic, color: Colors.white, height: 1.05),
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (i) {
                    return SizedBox(
                      width: 44,
                      child: TextField(
                        controller: _controllers[i],
                        focusNode: _focus[i],
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.08),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onChanged: (v) {
                          if (v.isNotEmpty && i < 5) _focus[i + 1].requestFocus();
                          setState(() {});
                        },
                      ),
                    );
                  }),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: _filled ? () => context.go(AppRoutes.gender) : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.navy,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: const Text('VERIFY & CONTINUE'),
                ),
                TextButton(
                  onPressed: _timer == 0 ? () => setState(() => _timer = 30) : null,
                  child: Text(_timer > 0 ? 'Resend in ${_timer}s' : 'Resend code'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
