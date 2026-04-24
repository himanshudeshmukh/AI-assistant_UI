import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/onboarding_header.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _phone = TextEditingController();

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.shellGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Column(
              children: [
                OnboardingHeader(onBack: () => context.go(AppRoutes.login)),
                const SizedBox(height: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(26)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'MEMBER · RESET',
                          style: TextStyle(fontSize: 9, letterSpacing: 3.2, color: AppColors.gold.withValues(alpha: 0.95), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text('Reset your\npassword.', style: TextStyle(fontSize: 30, height: 1.05, fontStyle: FontStyle.italic, color: Colors.white)),
                        const Spacer(),
                        TextField(
                          controller: _phone,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'PHONE',
                            prefixText: '+91 ',
                            prefixStyle: const TextStyle(color: Colors.white70),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2))),
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.gold)),
                          ),
                        ),
                        const Spacer(),
                        FilledButton(
                          onPressed: () => context.go(AppRoutes.otp),
                          style: FilledButton.styleFrom(backgroundColor: AppColors.gold, foregroundColor: AppColors.navy, minimumSize: const Size.fromHeight(48)),
                          child: const Text('SEND CODE', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 3)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
