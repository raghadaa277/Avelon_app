import 'package:flutter/material.dart';

class ProfileTheme {
  ProfileTheme._();

  // Brand
  static const Color primaryGreen = Color(0xFF7BC143);
  static const Color primaryGreenDark = Color(0xFF5FA82F);
  static const Color lightGreenBg = Color(0xFFE9F6DA);
  static const Color lightGreenBorder = Color(0xFFCDEAA6);

  // Relationship status panel (purple/lavender)
  static const Color purpleBg = Color(0xFFF4F1FB);
  static const Color purpleBorder = Color(0xFFD9CCF2);
  static const Color purpleIcon = Color(0xFF8E6FCE);

  // Semantic status accent colors
  static const Color noneGrey = Color(0xFF9E9E9E);
  static const Color followingGreen = Color(0xFF6FBF3B);
  static const Color followerBlue = Color(0xFF4A90D9);
  static const Color mutualPurple = Color(0xFF9B6FE0);

  // Indicator badges
  static const Color closeFriendGold = Color(0xFFF5B400);
  static const Color mutedOrange = Color(0xFFF08A24);
  static const Color reportedRed = Color(0xFFE24C4B);

  // Text / neutrals
  static const Color textDark = Color(0xFF1E1E1E);
  static const Color textGrey = Color(0xFF8A8A8A);
  static const Color divider = Color(0xFFE7E7E7);
  static const Color cardBg = Colors.white;
  static const Color pageBg = Color(0xFFF7F8F5);

  static const double radiusM = 12;
  static const double radiusL = 18;

  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: textGrey,
    letterSpacing: 0.4,
  );

  static const TextStyle nameStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: textDark,
  );

  static const TextStyle subtleStyle = TextStyle(fontSize: 13, color: textGrey);
}
