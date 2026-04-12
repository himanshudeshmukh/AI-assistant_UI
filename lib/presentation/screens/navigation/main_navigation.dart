import 'dart:io';

import 'package:flutter/material.dart';
import 'package:Kaivon/presentation/screens/home/wardrobe_gallery_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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

  final List<Widget> _pages = [
    const HomeScreen(),
    const GenerateScreen(),
    const WardrobeGalleryPage(),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    // 👇 Skip center empty item (index 2)
    if (index == 2) return;

    if (index > 2) {
      setState(() => _currentIndex = index - 1);
    } else {
      setState(() => _currentIndex = index);
    }
  }

  /* ================= UI ================= */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),

      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      /* ================= CENTER CAMERA FAB ================= */

      floatingActionButton: GestureDetector(
        onTap: _showPicker,
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFEAEAEA),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.camera_alt_outlined,
            size: 26,
            color: Color(0xFF2E2E2E),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      /* ================= NAVBAR ================= */

      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
        padding: const EdgeInsets.symmetric(vertical: 6),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFEAEAEA)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: BottomNavigationBar(
          currentIndex: _currentIndex >= 2
              ? _currentIndex + 1
              : _currentIndex,

          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,

          elevation: 0,
          backgroundColor: Colors.transparent,

          showSelectedLabels: true,
          showUnselectedLabels: true,

          selectedItemColor: const Color(0xFF2E2E2E),
          unselectedItemColor: Colors.grey,

          selectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),

          unselectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),

          items: [
            _navItem(Icons.home_outlined, Icons.home, "Home", 0),

            _navItem(FontAwesomeIcons.wandMagicSparkles,
                FontAwesomeIcons.wandMagicSparkles, "Generate", 1),

            const BottomNavigationBarItem(
              icon: SizedBox(),
              label: "",
            ),

            _navItem(FontAwesomeIcons.shirt,
                FontAwesomeIcons.shirt, "Wardrobe", 2),

            _navItem(FontAwesomeIcons.user,
                FontAwesomeIcons.user, "Profile", 3),
          ],
        ),
      ),
    );
  }

  /* ================= NAV ITEM ================= */

  BottomNavigationBarItem _navItem(
      IconData icon,
      IconData activeIcon,
      String label,
      int index,
      ) {
    final bool isActive = _currentIndex == index;

    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        size: 24,
        color: isActive ? const Color(0xFF2E2E2E) : Colors.grey,
      ),
      activeIcon: Icon(
        activeIcon,
        size: 26,
        color: const Color(0xFF2E2E2E),
      ),
      label: label,
    );
  }
}