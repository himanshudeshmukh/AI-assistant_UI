import 'package:flutter/material.dart';

class LikedOutfits extends StatelessWidget {
  const LikedOutfits({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          "Liked Outfits",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}