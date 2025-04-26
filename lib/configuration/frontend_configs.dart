import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF00A86D); // Green500
  static const Color secondary = Color(0xFFCB103F); // Secondary600
  static const Color kAuthColor =  Color(0xffF6F6F6);

  // Status Colors
  static const Color warning = Color(0xFFFAE635); // Yellow500
  static const Color error = Color(0xFFF44336); // Red500
  static const Color success = Color(0xFF4CAF51); // Green500
  static const Color info = Color(0xFFFBBA00); // Orange600

  // Background Colors
  static const Color bgLight = Color(0xFFFFFFFF); // White
  static const Color bgDark = Color(0xFF121212); // Black
  static const Color white = Color.fromARGB(255, 255, 255, 255); // Black


  // Text and Icon Colors
  static const Color contentPrimary = Color(0xFF212121); // Gray900
  static const Color contentSecondary = Color(0xFF414141); // Gray800
  static const Color contentTertiary = Color(0xFF5A5A5A); // Gray700
  static const Color contentDisabled = Color(0xFFB8B8B8); // Gray300
  

  // Additional Shades
  static const Color gray50 = Color(0xFFF7F7F7);
  static const Color gray100 = Color(0xFFE8E8E8);
  static const Color gray200 = Color(0xFFD0D0D0);
  static const Color gray300 = Color(0xFFB8B8B8);
  static const Color gray400 = Color(0xFFA0A0A0);
  static const Color gray500 = Color(0xFF898989);
  static const Color gray600 = Color(0xFF717171);
  static const Color gray700 = Color(0xFF5A5A5A);
  static const Color gray800 = Color(0xFF414141);
  static const Color gray900 = Color(0xFF2A2A2A);


  static TextStyle kHeadingStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 32,
      fontFamily: "Poppins");
}

