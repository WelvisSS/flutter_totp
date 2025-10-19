class AppConstants {
  // API Configuration
  static const String baseUrl = 'http://127.0.0.1:5000';

  static const String loginEndpoint = '/auth/login';
  static const String recoveryEndpoint = '/auth/recovery-secret';

  // Storage keys for SharedPreferences
  static const String totpSecretKey = 'totp_secret';
  static const String isLoggedInKey = 'is_logged_in';

  // Route names
  static const String loginRoute = '/login';
  static const String recoveryRoute = '/recovery';
  static const String homeRoute = '/home';

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 8.0;
}
