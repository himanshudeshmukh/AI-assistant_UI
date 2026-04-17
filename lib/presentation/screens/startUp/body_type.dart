import 'package:Kaivon/presentation/screens/auth/login_screen.dart';
import 'package:Kaivon/presentation/screens/navigation/main_navigation.dart';
import 'package:Kaivon/presentation/widgets/appBar.dart';
import 'package:flutter/material.dart';

import 'body_type.dart';

class BodyType extends StatefulWidget {
  const BodyType({super.key});

  @override
  State<BodyType> createState() => _BodyTypeState();
}

class _BodyTypeState extends State<BodyType> {

  String? selectedGender;

  void _handleGender(String gender) {
    setState(() {
      selectedGender = gender;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$gender selected")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFA8D8D8),
      appBar: CustomAppBar(
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ================= TITLE =================
              Text(
                "Choose Your Body Type",
                style: TextStyle(
                  fontSize: w * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: w * 0.06),

              // ================= GRID =================
              _buildMenuSection(w),

              SizedBox(height: w * 0.45),
              // ================= GRID =================
              LoginButton(height: h, width: w,nextScreen: const MainNavigation(), text: 'Next',),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuSection(double w) {
    final items = [
      {"title": "Hour Glass", "img": "assets/bodyType/girl_hourGlass.png"},
      {"title": "Pear", "img": "assets/bodyType/girl_pear.png"},
      {"title": "Hour Glass", "img": "assets/bodyType/girl_hourGlass.png"},
      {"title": "Pear", "img": "assets/bodyType/girl_pear.png"},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        final isSelected = selectedGender == item["title"];

        return _MenuCard(
          title: item["title"]!,
          imagePath: item["img"]!,
          isSelected: isSelected,
          onTap: () => _handleGender(item["title"]!),
        );
      },
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;
  final bool isSelected;

  const _MenuCard({
    required this.title,
    required this.imagePath,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: w * 0.35, // 👈 increase this
              width: w * 0.35,  // 👈 optional but makes layout stable
              fit: BoxFit.contain,
            ),

            SizedBox(height: w * 0.03),

            Text(
              title,
              style: TextStyle(
                fontSize: w * 0.04,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}