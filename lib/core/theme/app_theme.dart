import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Plus Jakarta Sans',

      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryContainer,
        secondary: AppColors.primary,
        secondaryContainer: Color(0x807A5D3E),
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.onPrimary,
        onSecondary: AppColors.onPrimary,
        onSurface: AppColors.onSurface,
        onError: AppColors.onPrimary,
        outline: AppColors.grey300,
        outlineVariant: AppColors.grey200,
        surfaceContainerHighest: AppColors.grey50,
      ),

      // Scaffold theme
      scaffoldBackgroundColor: AppColors.background,

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.onBackground,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.grey200,
        surfaceTintColor: AppColors.background,
        titleTextStyle: AppTypography.titleLarge,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),

      // Text theme
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        displaySmall: AppTypography.displaySmall,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        headlineSmall: AppTypography.headlineSmall,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        titleSmall: AppTypography.titleSmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.grey300,
          disabledForegroundColor: AppColors.grey500,
          elevation: 2,
          shadowColor: AppColors.primary.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: AppTypography.buttonMedium,
          minimumSize: const Size(double.infinity, 56),
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.grey500,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle:
              AppTypography.buttonMedium.copyWith(color: AppColors.primary),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.grey500,
          textStyle:
              AppTypography.buttonMedium.copyWith(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.grey300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.grey300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.grey200, width: 1),
        ),
        labelStyle:
            AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        hintStyle:
            AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        errorStyle: AppTypography.bodySmall.copyWith(color: AppColors.error),
        floatingLabelStyle:
            AppTypography.bodySmall.copyWith(color: AppColors.primary),
      ),

      // Card theme
      cardTheme: const CardThemeData(
        color: AppColors.background,
        elevation: 2,
        shadowColor: AppColors.grey200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        margin: EdgeInsets.all(8),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.grey200,
        thickness: 1,
        space: 1,
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle:
            TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle:
            TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        disabledColor: AppColors.grey200,
        selectedColor: AppColors.primary,
        secondarySelectedColor: AppColors.primaryWithOpacity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelStyle: AppTypography.bodyMedium,
        secondaryLabelStyle:
            AppTypography.bodyMedium.copyWith(color: AppColors.onPrimary),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF212229),
        contentTextStyle: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w500,
          fontSize: 12,
          height: 20 / 12,
          letterSpacing: -0.009 * 12,
          color: Color(0xFFFFFFFF),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        actionTextColor: AppColors.primary,
        width: 347,
      ),

      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.grey200,
        circularTrackColor: AppColors.grey200,
      ),
    );
  }

  static ThemeData get darkTheme {
    return lightTheme;
  }

  /// Private constructor to prevent instantiation
  AppTheme._();
}
