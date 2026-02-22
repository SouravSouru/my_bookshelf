import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// Primary color used for main buttons like 'Write a Review', 'Log In'
  static const Color primary = Color(0xFF6552E0);

  /// Dark background used on the login page banner
  static const Color primaryDark = Color(0xFF2C254A);

  /// General background of the screens
  static const Color background = Color(0xFFF9FAFC);

  /// White background for Cards, Input Fields, etc.
  static const Color cardBackground = Colors.white;

  /// Pure white
  static const Color white = Colors.white;

  /// Primary strong text color
  static const Color textPrimary = Color(0xFF1F1F39);

  /// Secondary muted text color
  static const Color textSecondary = Color(0xFF858597);

  /// Outline / Border colors (input fields, tags)
  static const Color border = Color(0xFFEAEAFF);

  /// Light filled unselected tags or pill-shape backgrounds
  static const Color surfaceLight = Color(0xFFF3F3FB);

  /// Error color (standard red)
  static const Color error = Color(0xFFFF5656);

  /// Rating Star Color (Yellow/Gold)
  static const Color ratingStar = Color(0xFFFFC000);

  /// Success/Done Color (Green)
  static const Color success = Color(0xFF5DD262);

  /// Active tab / Bottom Nav selected
  static const Color navSelected = primary;

  /// Inactive Bottom Nav
  static const Color navUnselected = Color(0xFFB8B8C7);
}
