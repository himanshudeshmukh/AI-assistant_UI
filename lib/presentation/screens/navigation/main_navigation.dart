import 'package:flutter/material.dart';
import 'package:profiler/config/theme/app_dimensions.dart';

import '../home/StylePage.dart';
import '../home/WalletPage.dart';
import '../home/home_screen.dart';
import '../home/profile_screen.dart';
import '../home/wardrobe_gallery_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {

  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    StylePage(),
    WardrobeGalleryPage(),
    ProfileScreen(),
  ];

  /// 🔥 Dynamic titles
  final List<String> titles = [
    "Home",
    "Style",
    "Wardrobe",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      /// 🔥 GLOBAL APPBAR
      appBar: AppBar(
        title: Text(titles[currentIndex]),

        automaticallyImplyLeading: false,
        /// 🔥 RIGHT WALLET ICON
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet_outlined),
            iconSize: AppDimensions.iconL,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const WalletPage(),
                ),
              );
            },
          ),
        ],
      ),

      /// 🔥 BODY
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      /// 🔥 BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),

        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_outlined),
            label: "Style",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checkroom),
            label: "Wardrobe",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}