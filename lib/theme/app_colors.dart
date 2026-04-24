import 'package:flutter/material.dart';

abstract final class AppColors {
  static const navy = Color(0xFF0C1543);
  static const gold = Color(0xFFE8B84A);
  static const goldDark = Color(0xFFC9972A);
  static const muted = Color(0xFF4D5070);
  static const slate = Color(0xFF6B6D7F);
  static const warmLabel = Color(0xFF7A5A10);

  static const shellGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFB8BBD0), Color(0xFFC8CBDD), Color(0xFFADB1C8)],
    stops: [0.0, 0.45, 1.0],
  );

  static const darkRadial = RadialGradient(
    center: Alignment(0, -0.9),
    radius: 1.15,
    colors: [Color(0xFF1A2463), Color(0xFF0C1543), Color(0xFF06091F)],
    stops: [0.0, 0.45, 1.0],
  );

  static const creamGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFAF5E8), Color(0xFFF5EFDD)],
  );
}
