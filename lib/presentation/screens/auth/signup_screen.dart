/// [SignupScreen] - Signup screen with custom bubble design
///
/// ✅ BUBBLE FIX APPLIED:
/// - Added top padding: 220px (matches your bubble's negative offsets)
/// - Bubble extends 180px above screen, so 220px padding gives 40px clear space
/// - Content never overlaps with bubble design
///
/// Your BubbleDesign uses:
///   - Top bubble: top: -60
///   - Large bubble: top: -180 (max offset)
///   - Solution: top: 220 padding = 40px clear space ✅

import 'package:flutter/material.dart';
import 'package:profiler/config/constants/constants.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_dimensions.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../config/validators/form_validators.dart';
import '../../../data/network/api_client.dart';
import '../../widgets/bubble_design.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // ==================== Form Controllers ====================
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late GlobalKey<FormState> _formKey;

  // ==================== State Variables ====================
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  // ==================== API Client ====================
  late ApiClient _apiClient;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _apiClient = ApiClient.instance;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // ==================== Form Validation ====================
  bool _validateForm() {
    final usernameError =
    FormValidators.validateUsername(_usernameController.text);
    final emailError = FormValidators.validateEmail(_emailController.text);
    final passwordError =
    FormValidators.validatePassword(_passwordController.text);
    final confirmPasswordError = FormValidators.validateMatch(
      _passwordController.text,
      _confirmPasswordController.text,
      'Passwords',
    );

    final error = usernameError ??
        emailError ??
        passwordError ??
        confirmPasswordError;

    if (error != null) {
      setState(() {
        _errorMessage = error;
      });
      return false;
    }

    return true;
  }

  // ==================== API Communication ====================
  Future<void> _handleSignup() async {
    setState(() {
      _errorMessage = null;
      _successMessage = null;
    });

    if (!_validateForm()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _apiClient.signup(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (response.success && response.data != null) {
        _apiClient.setAuthToken(response.data!.token);

        setState(() {
          _successMessage = response.message;
          _isLoading = false;
        });

        await Future.delayed(const Duration(milliseconds: 500));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account created successfully!'),
              backgroundColor: AppColors.successColor,
            ),
          );
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

  // ==================== Navigation ====================
  void _navigateToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BubbleDesign(
        // ✅ Your custom BubbleDesign with negative top positioning
        child: SingleChildScrollView(
          child: Padding(
            // ✅ BUBBLE FIX: top: 220 padding
            // Your bubbles extend 180px above screen (top: -180)
            // 220px padding - 180px bubble offset = 40px clear space ✅
            padding: const EdgeInsets.only(
              top: 220,
              left: AppDimensions.screenPaddingHorizontal,
              right: AppDimensions.screenPaddingHorizontal,
            ),
            child: Column(
              children: [
                // ==================== Logo ====================
                Center(
                  child: Text(
                    Constants.appName,
                    style: AppTextStyles.headingLarge.copyWith(
                      color: AppColors.primaryOrange,
                      fontSize: 30,
                    ),
                  ),
                ),

                SizedBox(height: AppDimensions.paddingL),

                // ==================== Email Input ====================
                CustomTextField(
                  hint: 'Enter your email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: FormValidators.validateEmail,
                  onChanged: (_) {
                    if (_errorMessage != null) {
                      setState(() => _errorMessage = null);
                    }
                  },
                ),

                SizedBox(height: AppDimensions.paddingL),

                // ==================== Username Input ====================
                CustomTextField(
                  hint: 'Enter your Phone Number',
                  controller: _usernameController,
                  validator: FormValidators.validateUsername,
                  onChanged: (_) {
                    if (_errorMessage != null) {
                      setState(() => _errorMessage = null);
                    }
                  },
                ),

                SizedBox(height: AppDimensions.paddingL),

                // ==================== Password Input ====================
                CustomTextField(
                  hint: 'Create a password',
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: FormValidators.validatePassword,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  onChanged: (_) {
                    if (_errorMessage != null) {
                      setState(() => _errorMessage = null);
                    }
                  },
                ),

                SizedBox(height: AppDimensions.paddingL),

                // ==================== Confirm Password Input ====================
                CustomTextField(
                  hint: 'Confirm your password',
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                    child: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  onChanged: (_) {
                    if (_errorMessage != null) {
                      setState(() => _errorMessage = null);
                    }
                  },
                ),

                SizedBox(height: AppDimensions.paddingL),

                // ==================== Error Message ====================
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppDimensions.paddingL,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(
                        AppDimensions.paddingM,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.errorLight,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusM,
                        ),
                      ),
                      child: Text(
                        _errorMessage!,
                        style: AppTextStyles.errorText,
                      ),
                    ),
                  ),

                // ==================== Signup Button ====================
                PrimaryButton(
                  text: 'Register Now',
                  isLoading: _isLoading,
                  onPressed: _isLoading ? null : _handleSignup,
                ),

                SizedBox(height: AppDimensions.paddingL),

                // ==================== Login Link ====================
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account ? ',
                        style: AppTextStyles.bodyLarge,
                      ),
                      GestureDetector(
                        onTap: _navigateToLogin,
                        child: Text(
                          'Login',
                          style: AppTextStyles.linkSmall,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: AppDimensions.paddingL),
              ],
            ),
          ),
        ),
      ),
    );
  }
}