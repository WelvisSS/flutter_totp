import 'package:flutter/material.dart';

class CustomSnackBar {
  /// Show success SnackBar
  static void showSuccess(BuildContext context, String message) {
    _showCustomSnackBar(
      context: context,
      message: message,
      backgroundColor: const Color(0xFF212229), // #212229
      textColor: const Color(0xFFFFFFFF), // #FFFFFF
    );
  }

  /// Show error SnackBar
  static void showError(BuildContext context, String message) {
    _showCustomSnackBar(
      context: context,
      message: message,
      backgroundColor: const Color(0xFF212229), // #212229
      textColor: const Color(0xFFFFFFFF), // #FFFFFF
    );
  }

  /// Show a general SnackBar with custom styling
  static void showInfo(BuildContext context, String message) {
    _showCustomSnackBar(
      context: context,
      message: message,
      backgroundColor: const Color(0xFF212229), // #212229
      textColor: const Color(0xFFFFFFFF), // #FFFFFF
    );
  }

  /// Internal method to show custom SnackBar
  static void _showCustomSnackBar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required Color textColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          width: 347,
          constraints: const BoxConstraints(
            minHeight: 56,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                offset: Offset(0, 3),
                blurRadius: 5,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Color(0x1F000000),
                offset: Offset(0, 1),
                blurRadius: 18,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Color(0x24000000),
                offset: Offset(0, 6),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              message,
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                height: 20 / 12,
                letterSpacing: -0.009 * 12,
                color: textColor,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
