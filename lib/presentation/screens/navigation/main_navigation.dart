import 'dart:io';

import 'package:flutter/material.dart';
import 'package:Kaivon/presentation/screens/home/wardrobe_gallery_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/theme/app_colors.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../home/recommendation_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  /* ================= IMAGE PICK ================= */

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() => _selectedImage = File(image.path));
    }
  }

  void _showPicker() {
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

  /* ================= PAGES ================= */

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      const HomeScreen(),
      const GenerateScreen(
        // onBackToHome: () {
        //   setState(() {
        //     _currentIndex = 0;
        //   });
        // },
      ),
      const WardrobeGalleryPage(
        // onBackToHome: () {
        //   setState(() {
        //     _currentIndex = 0;
        //   });
        // },
      ),
      ProfileScreen(
        onBackToHome: () {
          setState(() {
            _currentIndex = 0;
          });
        },
      ),
    ];
  }

  /* ================= BACK BUTTON HANDLER ================= */

  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      // If not on home tab, go back to home tab
      setState(() {
        _currentIndex = 0;
      });
      return false; // Prevent app from closing
    }
    // Already on home tab -> allow system to close app (or show dialog)
    return true;
  }

  /* ================= UI ================= */

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // We handle back navigation manually
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          final shouldPop = await _onWillPop();
          if (shouldPop) {
            Navigator.of(context).pop();
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

            // Show navbar ONLY on HomeScreen
            if (_currentIndex == 0)
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

  /* ================= NAVBAR (Only for Home) ================= */

  Widget _buildNavBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_rounded, 0),
          _navItem(FontAwesomeIcons.wandMagicSparkles, 1),

          /// 📸 CENTER CAMERA
          GestureDetector(
            onTap: _showPicker,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.black38,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                  )
                ],
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),

          _navItem(FontAwesomeIcons.shirt, 2),
          _navItem(FontAwesomeIcons.user, 3),
        ],
      ),
    );
  }

  /* ================= NAV ITEM ================= */

  Widget _navItem(IconData icon, int index) {
    final bool isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.softTeal200 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          size: 24,
          color: Colors.black,
        ),
      ),
    );
  }
}