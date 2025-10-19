import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'home',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 20 / 14,
            letterSpacing: -0.007 * 14,
            color: AppColors.grey500,
          ),
        ),
      ),
    );
  }
}
