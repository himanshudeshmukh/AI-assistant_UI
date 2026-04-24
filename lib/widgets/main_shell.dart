import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'main_bottom_nav.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB8BBD0), Color(0xFFC8CBDD), Color(0xFFADB1C8)],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom > 0 ? 4 : 0),
                child: child,
              ),
            ),
            MainBottomNav(currentPath: path),
          ],
        ),
      ),
    );
  }
}
