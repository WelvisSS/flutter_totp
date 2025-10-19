import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF7A5D3E);
  static const Color primaryContainer = Color(0xFF7A5D3E);

  // Surface colors
  static const Color surface = Color(0xFFF8F8FA);
  static const Color background = Color(0xFFFFFFFF);

  // Text colors
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF212229);
  static const Color onBackground = Color(0xFF212229);
  static const Color textSecondary = Color(0xFF9496AA);
  static const Color hintText = Color(0xFF8A8B96);
  static const Color labelText = Color(0xFF494A57);

  // Semantic colors
  static const Color error = Color(0xFFDC3545);

  // Additional shades
  static const Color grey50 = Color(0xFFF8F8FA);
  static const Color grey200 = Color(0xFFE8EAED);
  static const Color grey300 = Color(0xFFDADCE0);
  static const Color grey500 = Color(0xFF9496AA);

  // Input field colors
  static const Color inputFillColor = Color(0xFFF6F6F8);
  static const Color inputBorderColor = Color(0xFFE7E7EF);
  static const Color inputFocusedBorderColor = Color(0xFF7A5D3E);
  static const Color inputTextColor = Color(0xFF000000);

  // Opacity variants
  static Color get primaryWithOpacity => primary.withValues(alpha: 0.5);
  static Color get primaryDisabled => const Color(0x807A5D3E);

  /// Private constructor to prevent instantiation
  AppColors._();
}
