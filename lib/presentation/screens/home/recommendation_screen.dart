import 'package:flutter/material.dart';
import 'package:profiler/config/theme/app_colors.dart';

class GenerateScreen extends StatelessWidget {
  const GenerateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Text(
            'Generate outfit',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
      ),
    );
  }
}
