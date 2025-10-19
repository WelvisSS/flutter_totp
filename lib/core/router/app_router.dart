import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/recovery_secret_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../constants/app_constants.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppConstants.loginRoute,
    routes: [
      // Login Route
      GoRoute(
        path: AppConstants.loginRoute,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),

      // Recovery Route
      GoRoute(
        path: AppConstants.recoveryRoute,
        name: 'recovery',
        builder: (context, state) => const RecoverySecretPage(),
      ),

      // Home Route
      GoRoute(
        path: AppConstants.homeRoute,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
    ],

    // Error page for undefined routes
    errorBuilder: (context, state) => Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text(
                'Pagian não encontrada',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go(AppConstants.loginRoute),
                child: const Text('Ir para Login'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
