// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppColors {
  MaterialColor colorCustom = MaterialColor(0xFF000000, color);

  static const buttonColor = Color(0xFF535593);
  static const textColor = Color(0xFFFFFFFF);
}

Map<int, Color> color = {
  50: const Color(0xFFFAFAFA), // Almost white (10% opacity)
  100: const Color(0xFFF5F5F5), // Light grey (20% opacity)
  200: const Color(0xFFE0E0E0), // Medium grey (40% opacity)
  300: const Color(0xFFCCCCCC), // Light grey (50% opacity)
  400: const Color(0xFFB3B3B3), // Medium grey (70% opacity)
  500: const Color(0xFF9E9E9E), // Dark grey (80% opacity)
  600: const Color(0xFF757575), // Medium dark grey (90% opacity)
  700: const Color(0xFF616161), // Dark grey (95% opacity)
  800: const Color(0xFF424242), // Very dark grey (90% opacity)
  900: const Color(0xFF212121), // 40% darker
};
