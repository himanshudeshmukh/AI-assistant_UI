import 'package:Kaivon/config/theme/app_colors.dart';
import 'package:Kaivon/presentation/screens/auth/reset_password.dart';
import 'package:Kaivon/presentation/screens/auth/signup_screen.dart';
import 'package:Kaivon/presentation/screens/home/home_screen.dart';
import 'package:Kaivon/presentation/screens/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

import 'auth_widget.dart';

/*
  PIXEL-ACCURATE AUTH UI (WELCOME + LOGIN)
  - Fully dynamic sizing via LayoutBuilder
  - No MediaQuery
  - Modular, production-ready
  - Reusable components
*/

/* ===================== ROOT WRAPPER ===================== */

class AuthContainer extends StatelessWidget {
  final Widget child;

  const AuthContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        return Scaffold(
          body: Center(
            child: Container(
              width: w,
              height: h,
              color: AppColors.background,
              child: child,
            ),
          ),
        );
      },
    );
  }
}



/* ===================== LOGIN SCREEN ===================== */

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;

          return Stack(
            children: [

              /// 🌟 TOP BACKGROUND (LIMIT HEIGHT ONLY)
              TopContent(
                height: h * 0.45, // 🔥 FIX (was h full)
                width: w,
                showText: false,
              ),

              /// 🌊 WAVE (REDUCED HEIGHT)
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomWaveCard(
                  height: h * 0.82, // 🔥 FIX (was 0.8)
                ),
              ),

              /// 📱 CONTENT (SAFE POSITIONING)
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: h * 0.40), // 🔥 FIX ALIGNMENT

                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: w * 0.08,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: h * 0.03),

                      InputField(hint: 'Phone +91', width: w),

                      SizedBox(height: h * 0.02),

                      InputField(
                        hint: 'enter your password',
                        width: w,
                        isPassword: true,
                      ),

                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ResetPasswordScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: w * 0.03,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      ),

                      LoginButton(
                        width: w,
                        height: h,
                        text: 'Login',
                        nextScreen: const MainNavigation(),
                      ),

                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Don't have an account"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SignUpScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: w * 0.04,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}



class LoginButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final Widget nextScreen;

  const LoginButton({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    required this.nextScreen,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => nextScreen, // ✅ FIXED
        ),
      );
    },
        child:
        Container(
          width: double.infinity,
          height: height * 0.07,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(width * 0.03),
          ),
          alignment: Alignment.center,

            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.05,
              ),
            ),
          ),
        );
  }
}