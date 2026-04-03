import 'package:flutter/material.dart';

import '../../../config/constants/constants.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/validators/form_validators.dart';
import '../../widgets/auth_hero_primary_button.dart';
import '../../widgets/auth_hero_text_field.dart';
import '../../widgets/hero_section.dart';

/// Forgot password — collects email and shows a confirmation state (wire API when available).
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  static const double _heroHeight = 340;
  static const double _cardOverlap = 24;

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<AuthHeroTextFieldState> _emailKey =
      GlobalKey<AuthHeroTextFieldState>();

  bool _resetSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendReset() {
    final err = _emailKey.currentState?.validateField();
    if (err != null) return;
    setState(() => _resetSent = true);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: _heroHeight,
            child: HeroSection(
              height: _heroHeight,
              onBack: () => Navigator.of(context).pop(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.authHeroAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.mail_outline,
                      size: 24,
                      color: AppColors.authHeroAccent,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "We'll send you a link to get back in",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: _heroHeight - _cardOverlap,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.authCardSurface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: EdgeInsets.fromLTRB(24, 32, 24, 24 + bottomInset),
                child: !_resetSent
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Enter the email address associated with your account and we\'ll send you a password reset link.',
                            style: TextStyle(
                              color: AppColors.authTextSecondary,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          AuthHeroTextField(
                            key: _emailKey,
                            label: 'Email Address',
                            placeholder: 'you@example.com',
                            prefixIcon: Icons.mail_outline,
                            controller: _emailController,
                            validator: FormValidators.validateEmail,
                          ),
                          const SizedBox(height: 24),
                          AuthHeroPrimaryButton(
                            text: 'Send Reset Link',
                            onPressed: _sendReset,
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Remember your password? ',
                                style: TextStyle(
                                  color: AppColors.authTextSecondary,
                                  fontSize: 13,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: AppColors.authHeroAccent,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const SizedBox(height: 24),
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: AppColors.authHeroAccent.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.mail_outline,
                              size: 28,
                              color: AppColors.authHeroAccent,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Check your inbox',
                            style: TextStyle(
                              color: AppColors.authTextOnCard,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "We've sent a password reset link to ${_emailController.text.trim().isEmpty ? 'your email' : _emailController.text.trim()}. It may take a minute to arrive.",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.authTextSecondary,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 32),
                          AuthHeroPrimaryButton(
                            text: 'Back to Sign In',
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () => setState(() => _resetSent = false),
                            child: const Text(
                              "Didn't receive it? Resend",
                              style: TextStyle(
                                color: AppColors.authHeroAccent,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            Constants.appName,
                            style: TextStyle(
                              color: AppColors.authTextMuted,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
