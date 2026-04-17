import 'dart:async';
import 'package:Kaivon/presentation/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'package:Kaivon/config/theme/app_colors.dart';
import 'package:Kaivon/presentation/screens/startUp/gender_screen.dart';
import 'auth_widget.dart';
import 'reset_password.dart';

enum OtpFlow { signup, forgotPassword }

class OtpScreen extends StatefulWidget {
  final String phone;
  final OtpFlow flow;

  const OtpScreen({
    super.key,
    required this.phone,
    required this.flow,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with CodeAutoFill {
  final List<TextEditingController> controllers =
  List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
  List.generate(6, (_) => FocusNode());

  String otp = "";
  int seconds = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    listenForCode();
    startTimer();
  }

  @override
  void dispose() {
    cancel();
    timer?.cancel();
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  /// 🔢 SMS AUTO FILL
  @override
  void codeUpdated() {
    if (code != null && code!.length == 6) {
      setOtp(code!);
      verifyOtp();
    }
  }

  void setOtp(String value) {
    otp = value;
    for (int i = 0; i < 6; i++) {
      controllers[i].text = value[i];
    }
    setState(() {});
  }

  /// ⏱ TIMER
  void startTimer() {
    seconds = 60;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds == 0) {
        t.cancel();
      } else {
        setState(() => seconds--);
      }
    });
  }

  /// 🔥 VERIFY
  void verifyOtp() {
    if (otp.length < 6) return;

    if (widget.flow == OtpFlow.signup) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const GenderScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
      );
    }
  }

  void updateOtp() {
    otp = controllers.map((e) => e.text).join();

    if (otp.length == 6) {
      verifyOtp();
    }
  }

  Widget otpBox(int index, double boxSize) {
    return Container(
      width: boxSize,
      height: boxSize,

      /// 🔥 THIS ENFORCES PERFECT CIRCLE
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade100,
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),

      child: Center(
        child: TextField(
          controller: controllers[index],
          focusNode: focusNodes[index],
          keyboardType: TextInputType.number,

          textAlign: TextAlign.center,
          showCursor: false,

          maxLength: 1,
          maxLengthEnforcement: MaxLengthEnforcement.none,

          style: TextStyle(
            fontSize: boxSize * 0.45,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            height: 1,
          ),

          decoration: const InputDecoration(
            counterText: "",
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),

          onChanged: (value) {
            if (value.isNotEmpty) {
              if (index < 5) {
                FocusScope.of(context)
                    .requestFocus(focusNodes[index + 1]);
              } else {
                FocusScope.of(context).unfocus();
              }
            } else {
              if (index > 0) {
                FocusScope.of(context)
                    .requestFocus(focusNodes[index - 1]);
              }
            }

            otp = controllers.map((e) => e.text).join();

            if (otp.length == 6) {
              verifyOtp();
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 🔥 IMPORTANT
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(

        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;

          final boxSize = (w - (w * 0.2) - (w * 0.1)) / 6;

          return Stack(
            children: [

              /// 🌟 TOP CONTENT (BUBBLES LIVE HERE)
              TopContent(
                height: h * 0.45,
                width: w,
                showText: false,
              ),

              /// 🌊 WAVE
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: h * 0.85,
                    width: double.infinity,
                    color: const Color(0xFFF7FAFA),
                  ),
                ),
              ),

              /// 📱 CONTENT ON TOP
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    w * 0.08,
                    h * 0.18,
                    w * 0.08,
                    h * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: h * 0.1),

                      Text(
                        "Enter OTP",
                        style: TextStyle(
                          fontSize: w * 0.075,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: h * 0.01),

                      Text(
                        "OTP sent to ${widget.phone}",
                        style: const TextStyle(color: Colors.black45),
                      ),

                      SizedBox(height: h * 0.04),

                      /// OTP ROW (WILL WORK NOW)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (i) {
                          return Padding(
                            padding: EdgeInsets.only(
                              right: i != 5 ? w * 0.02 : 0,
                            ),
                            child: otpBox(i, boxSize),
                          );
                        }),
                      ),

                      SizedBox(height: h * 0.04),

                      SizedBox(
                        width: double.infinity,
                        height: h * 0.065,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.background,
                          ),
                          // onPressed: verifyOtp,
                          onPressed: ()
                          {
                            Navigator.push(context, MaterialPageRoute( builder: (_) => const GenderScreen(),),);
                          },
                          child: const Text(
                            "Verify",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      Center(
                        child: TextButton(
                          onPressed: seconds == 0 ? startTimer : null,
                          child: Text(
                            seconds == 0
                                ? "Resend OTP"
                                : "Resend in ${seconds}s",
                            style: TextStyle(
                              color: AppColors.background
                            ),
                          ),
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