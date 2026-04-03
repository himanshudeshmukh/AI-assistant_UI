/// Signup screen — Victus-style hero layout with existing [ApiClient] integration.
library;

import 'package:flutter/material.dart';

import '../../../config/constants/constants.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/validators/form_validators.dart';
import '../../../data/network/api_client.dart';
import '../../widgets/auth_hero_primary_button.dart';
import '../../widgets/auth_hero_text_field.dart';
import '../../widgets/hero_section.dart';
import '../../widgets/social_auth_row.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  static const double _heroHeight = 260;
  static const double _cardOverlap = 24;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  late GlobalKey<AuthHeroTextFieldState> _nameFieldKey;
  late GlobalKey<AuthHeroTextFieldState> _emailFieldKey;
  late GlobalKey<AuthHeroTextFieldState> _passwordFieldKey;
  late GlobalKey<AuthHeroTextFieldState> _confirmFieldKey;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  late ApiClient _apiClient;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _nameFieldKey = GlobalKey<AuthHeroTextFieldState>();
    _emailFieldKey = GlobalKey<AuthHeroTextFieldState>();
    _passwordFieldKey = GlobalKey<AuthHeroTextFieldState>();
    _confirmFieldKey = GlobalKey<AuthHeroTextFieldState>();
    _apiClient = ApiClient.instance;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Spaces → underscores so [FormValidators.validateUsername] can run on API username.
  String _usernameForApi(String fullName) {
    return fullName.trim().replaceAll(RegExp(r'\s+'), '_');
  }

  String? _validateName(String value) {
    final t = value.trim();
    return FormValidators.validateRequired(t, 'Full name') ??
        FormValidators.validateMinLength(t, 2, 'Full name') ??
        FormValidators.validateUsername(_usernameForApi(value));
  }

  bool _validateForm() {
    setState(() => _errorMessage = null);

    if (_nameFieldKey.currentState?.validateField() != null) return false;
    if (_emailFieldKey.currentState?.validateField() != null) return false;
    if (_passwordFieldKey.currentState?.validateField() != null) return false;
    if (_confirmFieldKey.currentState?.validateField() != null) return false;

    return true;
  }

  Future<void> _handleSignup() async {
    setState(() => _errorMessage = null);

    if (!_validateForm()) return;

    setState(() => _isLoading = true);

    try {
      final response = await _apiClient.signup(
        username: _usernameForApi(_nameController.text),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (response.success && response.data != null) {
        _apiClient.setAuthToken(response.data!.token);

        setState(() => _isLoading = false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully!'),
            backgroundColor: AppColors.successColor,
          ),
        );

        await Future.delayed(const Duration(milliseconds: 400));
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      } else {
        setState(() {
          _errorMessage = response.message ?? 'Signup failed';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _handleGoogleLogin() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google sign-in not yet implemented')),
    );
  }

  void _handleAppleLogin() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Apple sign-in not yet implemented')),
    );
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
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        size: 16,
                        color: AppColors.authHeroAccent,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'JOIN ${Constants.appName.toUpperCase()}',
                        style: TextStyle(
                          color: AppColors.authHeroAccent,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Start your AI-powered style journey',
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
                padding: EdgeInsets.fromLTRB(24, 28, 24, 24 + bottomInset),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthHeroTextField(
                      key: _nameFieldKey,
                      label: 'Full Name',
                      placeholder: 'Your full name',
                      prefixIcon: Icons.person_outline,
                      controller: _nameController,
                      validator: _validateName,
                    ),
                    const SizedBox(height: 14),
                    AuthHeroTextField(
                      key: _emailFieldKey,
                      label: 'Email',
                      placeholder: 'you@example.com',
                      prefixIcon: Icons.mail_outline,
                      controller: _emailController,
                      validator: FormValidators.validateEmail,
                    ),
                    const SizedBox(height: 14),
                    AuthHeroTextField(
                      key: _passwordFieldKey,
                      label: 'Password',
                      placeholder: 'Create password',
                      prefixIcon: Icons.lock_outline,
                      controller: _passwordController,
                      isPassword: true,
                      obscureText: _obscurePassword,
                      onToggleVisibility: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      validator: FormValidators.validatePassword,
                      hint: 'Min. 8 characters with a number & symbol',
                    ),
                    const SizedBox(height: 14),
                    AuthHeroTextField(
                      key: _confirmFieldKey,
                      label: 'Confirm Password',
                      placeholder: 'Re-enter password',
                      prefixIcon: Icons.lock_outline,
                      controller: _confirmPasswordController,
                      isPassword: true,
                      obscureText: _obscureConfirmPassword,
                      onToggleVisibility: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return FormValidators.validateMatch(
                          value,
                          _passwordController.text,
                          'Passwords',
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          color: AppColors.authTextMuted,
                          fontSize: 11,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: 'By creating an account, you agree to our ',
                          ),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              color: AppColors.authHeroAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: AppColors.authHeroAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_errorMessage != null && _errorMessage!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.errorLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: AppColors.errorColor,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    AuthHeroPrimaryButton(
                      text: 'Create Account',
                      isLoading: _isLoading,
                      onPressed: _isLoading ? null : _handleSignup,
                    ),
                    const SizedBox(height: 16),
                    SocialAuthRow(
                      onGoogle: _handleGoogleLogin,
                      onApple: _handleAppleLogin,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
