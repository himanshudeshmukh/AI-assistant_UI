import 'package:flutter/material.dart';

import '../../../config/theme/app_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          "Ankit will work on this Page",
          style: AppTextStyles.headingLarge,
        ),
      ),
    );
  }
}