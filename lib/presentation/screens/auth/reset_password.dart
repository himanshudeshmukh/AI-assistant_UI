import 'package:Kaivon/config/theme/app_colors.dart';
import 'package:Kaivon/presentation/screens/auth/reset_password.dart';
import 'package:Kaivon/presentation/screens/auth/signup_screen.dart';
import 'package:Kaivon/presentation/screens/home/home_screen.dart';
import 'package:Kaivon/presentation/screens/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

import 'auth_widget.dart';
import 'login_screen.dart';

/*
  PIXEL-ACCURATE AUTH UI (WELCOME + LOGIN)
  - Fully dynamic sizing via LayoutBuilder
  - No MediaQuery
  - Modular, production-ready
  - Reusable components
*/



/* ===================== LOGIN SCREEN ===================== */

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
                  height: h * 0.90, // 🔥 FIX (was 0.8)
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
                        'Reset Password',
                        style: TextStyle(
                          fontSize: w * 0.08,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: h * 0.03),

                      InputField(hint: 'Enter new Password', width: w),

                      SizedBox(height: h * 0.02),

                      InputField(
                        hint: 'Re-enter your password',
                        width: w,
                        isPassword: true,
                      ),
                      SizedBox(height: h * 0.03),
                      LoginButton(
                        width: w,
                        height: h,
                        text: 'Reset',
                        nextScreen: const MainNavigation(),
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