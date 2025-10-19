import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTypography {
  static const String _fontFamily = 'Plus Jakarta Sans';
  // Display styles
  static TextStyle get displayLarge => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: AppColors.onBackground,
      );

  static TextStyle get displayMedium => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.onBackground,
      );

  static TextStyle get displaySmall => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.onBackground,
      );

  // Headline styles
  static TextStyle get headlineLarge => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.onBackground,
      );

  static TextStyle get headlineMedium => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.onBackground,
      );

  static TextStyle get headlineSmall => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: AppColors.onBackground,
      );

  // Title styles
  static TextStyle get titleLarge => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: AppColors.onBackground,
      );

  static TextStyle get titleMedium => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: AppColors.onBackground,
      );

  static TextStyle get titleSmall => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: AppColors.onBackground,
      );

  // Label styles
  static TextStyle get labelLarge => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: AppColors.onBackground,
      );

  static TextStyle get labelMedium => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: AppColors.onBackground,
      );

  static TextStyle get labelSmall => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: AppColors.onBackground,
      );

  // Body styles
  static TextStyle get bodyLarge => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: AppColors.onBackground,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: AppColors.onBackground,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: AppColors.textSecondary,
      );

  // Button styles
  static TextStyle get buttonMedium => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: AppColors.onPrimary,
      );

  static TextStyle get loginButton => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 20 / 13,
        letterSpacing: 0,
        color: AppColors.onPrimary,
      );

  static TextStyle get inputHint => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 20 / 12,
        letterSpacing: -0.009,
        color: AppColors.hintText,
      );

  static TextStyle get inputLabel => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 20 / 12,
        letterSpacing: -0.009,
        color: AppColors.labelText,
      );

  static TextStyle get inputText => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 20 / 14,
        letterSpacing: -0.007,
        color: AppColors.onSurface,
      );

  static TextStyle get errorText => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 16 / 12,
        letterSpacing: -0.009,
        color: AppColors.error,
      );

  static TextStyle get forgotPasswordButton => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 20 / 13,
        letterSpacing: 0,
        color: AppColors.primary,
      );

  static TextStyle get verificationTitle => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 32 / 20,
        letterSpacing: -0.017,
        color: AppColors.onSurface,
      );

  static TextStyle get verificationInstruction => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 20 / 14,
        letterSpacing: -0.007,
        color: AppColors.textSecondary,
      );

  static TextStyle get codeNotReceivedButton => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 20 / 13,
        letterSpacing: 0,
        color: AppColors.labelText,
      );

  /// Private constructor to prevent instantiation
  AppTypography._();
}
