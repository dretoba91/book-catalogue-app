// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppColors {
  MaterialColor colorCustom = MaterialColor(0xFF000000, color);

  static const Color buttonColor = Color(0xFF535593);
  static const Color secondButtonColor = Color(0xFF4F4F4F);
  static const Color secondaryRedColor = Color.fromARGB(255, 240, 84, 84);
  static const Color textFieldBackgroundColor = Color(0xFF2D2D2D);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color textgrey = Color(0xffC9C9C9);
  static const Color blackColor = Color(0xFF252525);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color blackBackground = Color(0xff000000);
  static const Color borderColor = Color(0xffD9D9D9);
  static const Color cardBgColor = Color(0xff242424);
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

MaterialColor colorCustom = MaterialColor(0xFF000000, color);
