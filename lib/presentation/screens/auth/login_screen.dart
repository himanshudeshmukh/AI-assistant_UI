/// Login screen — Victus-style hero layout with existing [ApiClient] integration.
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  static const double _heroHeight = 380;
  static const double _cardOverlap = 24;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<AuthHeroTextFieldState> _emailFieldKey;
  late GlobalKey<AuthHeroTextFieldState> _passwordFieldKey;

  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  late ApiClient _apiClient;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFieldKey = GlobalKey<AuthHeroTextFieldState>();
    _passwordFieldKey = GlobalKey<AuthHeroTextFieldState>();
    _apiClient = ApiClient.instance;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    bool isValid = true;
    setState(() => _errorMessage = null);

    if (_emailFieldKey.currentState?.validateField() != null) {
      isValid = false;
    }
    if (_passwordFieldKey.currentState?.validateField() != null) {
      isValid = false;
    }
    return isValid;
  }

  Future<void> _handleLogin() async {
    setState(() {
      _errorMessage = null;
      _successMessage = null;
    });

    if (!_validateForm()) return;

    setState(() => _isLoading = true);

    try {
      final response = await _apiClient.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (response.success && response.data != null) {
        _apiClient.setAuthToken(response.data!.token);
        _emailFieldKey.currentState?.clearError();
        _passwordFieldKey.currentState?.clearError();

        setState(() {
          _successMessage = response.message ?? 'Login successful!';
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcome ${response.data!.username}!'),
            backgroundColor: AppColors.successColor,
            duration: const Duration(seconds: 2),
          ),
        );

        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } else {
        setState(() {
          _errorMessage = response.message ?? 'Login failed. Please try again.';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Connection error: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToSignup() {
    Navigator.of(context).pushNamed('/signup');
  }

  void _navigateToForgotPassword() {
    Navigator.of(context).pushNamed('/forgot-password');
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        size: 20,
                        color: AppColors.authHeroAccent,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'AI-POWERED STYLE',
                        style: TextStyle(
                          color: AppColors.authHeroAccent,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    Constants.appName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Premium Lifestyle Ecosystem',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 0.5,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome back',
                      style: TextStyle(
                        color: AppColors.authTextOnCard,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Sign in to continue your style journey',
                      style: TextStyle(
                        color: AppColors.authTextSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AuthHeroTextField(
                      key: _emailFieldKey,
                      label: 'Email',
                      placeholder: 'you@example.com',
                      prefixIcon: Icons.mail_outline,
                      controller: _emailController,
                      validator: FormValidators.validateEmail,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'PASSWORD',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: AppColors.authTextOnCard,
                          ),
                        ),
                        GestureDetector(
                          onTap: _navigateToForgotPassword,
                          child: const Text(
                            'Forgot?',
                            style: TextStyle(
                              color: AppColors.authHeroAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    AuthHeroTextField(
                      key: _passwordFieldKey,
                      label: '',
                      placeholder: 'Enter password',
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
                    if (_successMessage != null && _successMessage!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.successColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.successColor),
                          ),
                          child: Text(
                            _successMessage!,
                            style: const TextStyle(
                              color: AppColors.successColor,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),
                    AuthHeroPrimaryButton(
                      text: 'Login',
                      isLoading: _isLoading,
                      onPressed: _isLoading ? null : _handleLogin,
                    ),
                    const SizedBox(height: 20),
                    SocialAuthRow(
                      onGoogle: _handleGoogleLogin,
                      onApple: _handleAppleLogin,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New to ${Constants.appName}? ',
                          style: const TextStyle(
                            color: AppColors.authTextSecondary,
                            fontSize: 13,
                          ),
                        ),
                        GestureDetector(
                          onTap: _navigateToSignup,
                          child: const Text(
                            'Create Account',
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
