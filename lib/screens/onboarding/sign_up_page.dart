import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/onboarding_header.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _name = TextEditingController();
  final _phone = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
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
                OnboardingHeader(onBack: () => context.go(AppRoutes.concierge)),
                const SizedBox(height: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(26)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'STEP 01 · ACCOUNT',
                          style: TextStyle(fontSize: 9, letterSpacing: 3.2, color: AppColors.gold.withValues(alpha: 0.95), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Create\nyour account.',
                          style: TextStyle(fontSize: 30, height: 1.05, fontStyle: FontStyle.italic, color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _name,
                          style: const TextStyle(color: Colors.white, fontSize: 15),
                          decoration: _underline('NAME', 'Himanshu Deshmukh'),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _phone,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(color: Colors.white, fontSize: 15),
                          decoration: _underline('PHONE', '98765 43210').copyWith(
                            prefixText: '+91 ',
                            prefixStyle: const TextStyle(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Spacer(),
                        FilledButton(
                          onPressed: () => context.go(AppRoutes.otp),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.gold,
                            foregroundColor: AppColors.navy,
                            minimumSize: const Size.fromHeight(48),
                          ),
                          child: const Text('CONTINUE', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 3)),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: () => context.go(AppRoutes.otp),
                          icon: const Icon(Icons.apple, color: AppColors.navy),
                          label: const Text('Continue with Apple'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.navy,
                            backgroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(46),
                          ),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () => context.go(AppRoutes.otp),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.navy,
                            backgroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(46),
                          ),
                          child: const Text('Continue with Google'),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => context.go(AppRoutes.login),
                  child: const Text('Already a member? Log in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _underline(String label, String hint) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(fontSize: 9, letterSpacing: 2.8, color: Colors.white.withValues(alpha: 0.5), fontWeight: FontWeight.bold),
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2))),
      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.gold)),
    );
  }
}
