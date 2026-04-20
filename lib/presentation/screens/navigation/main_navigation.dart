import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:Kaivon/config/theme/app_colors.dart';

import '../explorer/explorer.dart';
import '../home/home_screen.dart';
import '../home/recommendation_screen.dart';
import '../home/wardrobe_gallery_page.dart';
import '../profile/profile_screen.dart';
import 'moder_nav_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  late final List<Widget> _pages = [
    const HomeScreen(),
    const GenerateScreen(),
    const WardrobeGalleryPage(),
    // ProfileScreen(
    //   onBackToHome: () => setState(() => _currentIndex = 0),
    // ),
    const Explorer(),
  ];

  // ================= IMAGE PICK =================
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (image == null) return;

      setState(() {
        _selectedImage = File(image.path);
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            source == ImageSource.camera
                ? "Photo captured"
                : "Image selected",
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ================= BOTTOM SHEET =================
  void _showImageSourcePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFF5F6F7),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.photo_outlined),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ================= BACK HANDLING =================
  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      return false;
    }

    return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Exit App"),
        content: const Text("Do you want to exit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Exit"),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          final shouldPop = await _onWillPop();
          if (shouldPop && mounted) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F3F5),
        body: Stack(
          children: [
            IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: _buildNavBar(),
            ),
          ],
        ),
      ),
    );
  }

  // ================= NAV BAR =================
  Widget _buildNavBar() {
    final w = MediaQuery.of(context).size.width;

    return ModernNavigationBar(
      currentIndex: _currentIndex,
      onTabChange: (index) {
        setState(() => _currentIndex = index);
      },
      onCameraPressed: _showImageSourcePicker,

      // ✅ NOW FULLY DYNAMIC
      height: w * 0.18,
      borderRadius: w * 0.08,
      elevation: w * 0.02,

      backgroundColor: Colors.cyan.withOpacity(0.4),
      activeColor: AppColors.softTeal300,
    );
  }
}