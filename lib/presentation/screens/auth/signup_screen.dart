import 'package:Kaivon/config/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth_widget.dart';
import 'login_screen.dart';
import 'otp_screen.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;

          return Stack(
            children: [
              /// 🔴 TOP BACKGROUND
              TopContent(height: h * 0.45, width: w, showText: false,),

              /// ⚪ WAVE + CONTENT (SAME LAYER → NO OVERLAP)
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: h * 0.95,
                    width: double.infinity,
                    color: Colors.white,

                    /// ✅ CONTENT INSIDE WAVE
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        w * 0.08,
                        h * 0.25, // 🔥 PUSH BELOW WAVE CURVE (KEY FIX)
                        w * 0.08,
                        h * 0.04,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// TITLE (NOW SAFE)
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: w * 0.075,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: h * 0.02),

                          /// INPUTS
                          InputField(hint: 'Name', width: w),
                          SizedBox(height: h * 0.015),

                          InputField(hint: 'demo@email.com', width: w),
                          SizedBox(height: h * 0.015),

                          InputField(hint: 'Phone +91', width: w),
                          SizedBox(height: h * 0.015),

                          InputField(
                            hint: 'Password',
                            width: w,
                            isPassword: true,
                          ),

                          SizedBox(height: h * 0.04),

                          /// SIGNUP BUTTON
                          SignupButton(width: w, height: h),

                          SizedBox(height: h * 0.025),

                          /// 🔥 SOCIAL ICONS (NOT BUTTONS)
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.network(
                                    "https://cdn-icons-png.flaticon.com/512/2991/2991148.png",
                                    height: h * 0.035,
                                  ),
                                ),
                                SizedBox(width: w * 0.04),
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.network(
                                    "https://cdn-icons-png.flaticon.com/512/733/733547.png",
                                    height: h * 0.035,
                                  ),
                                ),
                              ],
                            ),
                          ),


                          /// LOGIN NAV (RIGHT SHIFTED CLEANLY)
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Already have an account? "),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: w * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.welcomeScreenColor,
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


class SignupButton extends StatelessWidget {
  final double width;
  final double height;

  const SignupButton({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height * 0.07,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(width * 0.03),
      ),
      alignment: Alignment.center,
      child: TextButton(
        onPressed: ()
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OtpScreen(
                phone: "+91 9876543210",
                flow: OtpFlow.signup,
              ),
            ),
          );
        },
        child: Text('SignUp',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.04,
          ),),
      ),
    );
  }
}