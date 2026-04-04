import 'package:flutter/cupertino.dart';
import 'package:profiler/config/theme/app_colors.dart';

class BubbleDesign extends StatelessWidget {
  final Widget child;

  const BubbleDesign({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        /// Top bubble
        Positioned(
          top:-60,
          right: -30,
          child: Container(
            height: MediaQuery.of(context).size.height/4,
            width: MediaQuery.of(context).size.height/4,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.splashBg,
                  AppColors.waveColor,
                ],
              ),
            ),
          ),
        ),

        /// Second bubble
        Positioned(
          top: -340,
          left: -130,
          child: Container(
            height: MediaQuery.of(context).size.height/1,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.splashBg,
                  AppColors.waveColor,
                ],
              ),
            ),
          ),
        ),

        SafeArea(child: child),
      ],
    );
  }
}