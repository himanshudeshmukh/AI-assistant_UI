import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/onboarding_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phone = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
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
                OnboardingHeader(onBack: () => context.go(AppRoutes.welcome)),
                const SizedBox(height: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(26)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'MEMBER · LOG IN',
                          style: TextStyle(fontSize: 9, letterSpacing: 3.2, color: AppColors.gold.withValues(alpha: 0.95), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text('Welcome\nback.', style: TextStyle(fontSize: 30, height: 1.05, fontStyle: FontStyle.italic, color: Colors.white)),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _phone,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'PHONE',
                            labelStyle: TextStyle(fontSize: 9, letterSpacing: 2.8, color: Colors.white.withValues(alpha: 0.5)),
                            prefixText: '+91 ',
                            prefixStyle: const TextStyle(color: Colors.white70, fontSize: 15),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2))),
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.gold)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('PASSWORD', style: TextStyle(fontSize: 9, letterSpacing: 2.8, color: Colors.white.withValues(alpha: 0.5))),
                            TextButton(onPressed: () => context.go(AppRoutes.forgot), child: const Text('FORGOT?', style: TextStyle(color: AppColors.gold, fontSize: 9))),
                          ],
                        ),
                        TextField(
                          controller: _password,
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: '••••••••',
                            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2))),
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.gold)),
                          ),
                        ),
                        const Spacer(),
                        FilledButton(
                          onPressed: () => context.go(AppRoutes.home),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.gold,
                            foregroundColor: AppColors.navy,
                            minimumSize: const Size.fromHeight(48),
                          ),
                          child: const Text('ENTER', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 3)),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(onPressed: () => context.go(AppRoutes.signUp), child: const Text('New here? Create account')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
