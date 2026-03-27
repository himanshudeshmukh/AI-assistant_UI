/// [LoginScreen] - Login screen with custom bubble design
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
import 'package:profiler/presentation/screens/auth/signup_screen.dart';
import 'package:profiler/presentation/screens/splash_screen.dart';
import '../../../config/constants/constants.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_dimensions.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../config/validators/form_validators.dart';
import '../../../data/network/api_client.dart';
import '../../widgets/bubble_design.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../home/home_screen.dart';
import '../navigation/main_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  // ==================== Form Controllers ====================
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<CustomTextFieldState> _emailFieldKey;
  late GlobalKey<CustomTextFieldState> _passwordFieldKey;

  // ==================== State Variables ====================
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  // ==================== API Client ====================
  late ApiClient _apiClient;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFieldKey = GlobalKey<CustomTextFieldState>();
    _passwordFieldKey = GlobalKey<CustomTextFieldState>();
    _apiClient = ApiClient.instance;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ==================== Form Validation ====================
  bool _validateForm() {
    bool isValid = true;
    setState(() => _errorMessage = null);

    final emailError = _emailFieldKey.currentState?.validateField();
    if (emailError != null) {
      isValid = false;
    }

    final passwordError = _passwordFieldKey.currentState?.validateField();
    if (passwordError != null) {
      isValid = false;
    }

    return isValid;
  }

  // ==================== API Communication ====================
  Future<void> _handleLogin() async {
    print('========== LOGIN BUTTON CLICKED ==========');
    print('Email: ${_emailController.text.trim()}');
    print('========================================');

    setState(() {
      _errorMessage = null;
      _successMessage = null;
    });

    if (!_validateForm()) {
      print('❌ Form validation failed');
      return;
    }

    setState(() => _isLoading = true);

    try {
      print('📤 Sending login request to API...');

      final response = await _apiClient.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      print('📥 Received response: ${response.success}');

      if (response.success && response.data != null) {
        print('✅ Login successful!');

        _apiClient.setAuthToken(response.data!.token);
        _emailFieldKey.currentState?.clearError();
        _passwordFieldKey.currentState?.clearError();

        setState(() {
          _successMessage = response.message ?? 'Login successful!';
          _isLoading = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Welcome ${response.data!.username}!'),
              backgroundColor: AppColors.successColor,
              duration: const Duration(seconds: 2),
            ),
          );
        }

        await Future.delayed(const Duration(milliseconds: 500));

        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } else {
        print('❌ Login failed: ${response.message}');
        setState(() {
          _errorMessage = response.message ?? 'Login failed. Please try again.';
          _isLoading = false;
        });
      }
    } catch (e) {
      print('❌ Exception: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Connection error: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  // ==================== Navigation ====================
  void _navigateToSignup() {
    print('Navigating to signup screen...');
    Navigator.of(context).pushNamed('/signup');
  }

  void _navigateToForgotPassword() {
    print('Navigating to forgot password screen...');
    Navigator.of(context).pushNamed('/forgotPassword');
  }

  void _handleFacebookLogin() {
    print('Facebook login clicked');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Facebook login not yet implemented')),
    );
  }

  void _handleGmailLogin() {
    print('Gmail login clicked');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Gmail login not yet implemented')),
    );
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
                  child: Column(
                    children: [
                      Text(
                        Constants.appName,
                        style: AppTextStyles.headingLarge.copyWith(
                          color: AppColors.primaryOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: AppDimensions.paddingS),
                    ],
                  ),
                ),

                SizedBox(height: AppDimensions.paddingL),

                // ==================== Form Fields ====================
                // ==================== Email Input ====================
                CustomTextField(
                  key: _emailFieldKey,
                  hint: 'Enter your email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: FormValidators.validateEmail,
                ),

                SizedBox(height: AppDimensions.paddingL),

                // ==================== Password Input ====================
                CustomTextField(
                  key: _passwordFieldKey,
                  hint: 'Enter your password',
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
                ),

                SizedBox(height: AppDimensions.paddingL),

                // ==================== Error Message ====================
                if (_errorMessage != null && _errorMessage!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppDimensions.paddingL,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingM),
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

                // ==================== Success Message ====================
                if (_successMessage != null && _successMessage!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppDimensions.paddingL,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingM),
                      decoration: BoxDecoration(
                        color: AppColors.successColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusM,
                        ),
                        border: Border.all(
                          color: AppColors.successColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        _successMessage!,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.successColor,
                        ),
                      ),
                    ),
                  ),

                // ==================== Login Button ====================
                PrimaryButton(
                  text: 'Login',
                  isLoading: _isLoading,
                  // onPressed: _isLoading ? null : _handleLogin,
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => MainNavigation()));
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MainNavigation()));
                  }
                ),


                SizedBox(height: AppDimensions.paddingM),

                // ==================== Forgot Password ====================
                Center(
                  child: GestureDetector(
                    onTap: _navigateToForgotPassword,
                    child: Text(
                      'Forgot Password ?',
                      style: AppTextStyles.linkSmall,
                    ),
                  ),
                ),

                SizedBox(height: AppDimensions.paddingM),

                // ==================== Divider ====================
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: AppColors.dividerColor,
                        thickness: AppDimensions.dividerThickness,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingM,
                      ),
                      child: Text(
                        'or',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: AppColors.dividerColor,
                        thickness: AppDimensions.dividerThickness,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppDimensions.paddingM),

                // ==================== Social Login ====================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      color: AppColors.facebookBlue,
                      onPressed: _handleFacebookLogin,
                      icon: const Icon(Icons.facebook),
                      iconSize: 48,
                    ),
                    SizedBox(width: AppDimensions.paddingL),
                    IconButton(
                      color: Colors.red,
                      onPressed: _handleGmailLogin,
                      icon: const Icon(Icons.mail_outlined),
                      iconSize: 48,
                    ),
                  ],
                ),

                SizedBox(height: AppDimensions.paddingL),

                // ==================== Signup Link ====================
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ? ",
                        style: AppTextStyles.bodyLarge,
                      ),
                      GestureDetector(
                        onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (_) => const SignupScreen(),
                ),
                );
                },
                        child: Text(
                          'Register',
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