import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';

abstract class AuthLocalDataSource {
  Future<bool> hasSecret();
  Future<String> getSecret();
  Future<void> storeSecret(String secret);
  Future<bool> isAuthenticated();
  Future<void> setAuthenticated(bool isAuthenticated);
  Future<void> clearAuthData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  const AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> hasSecret() async {
    final secret = sharedPreferences.getString(AppConstants.totpSecretKey);
    return secret != null && secret.isNotEmpty;
  }

  @override
  Future<String> getSecret() async {
    final secret = sharedPreferences.getString(AppConstants.totpSecretKey);
    if (secret == null || secret.isEmpty) {
      // TOTP secret not found
      throw const CacheException('Ops, problemas técnicos');
    }
    return secret;
  }

  @override
  Future<void> storeSecret(String secret) async {
    final success = await sharedPreferences.setString(
      AppConstants.totpSecretKey,
      secret,
    );
    if (!success) {
      // Failed to store TOTP secret
      throw const CacheException('Ops, problemas técnicos');
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    return sharedPreferences.getBool(AppConstants.isLoggedInKey) ?? false;
  }

  @override
  Future<void> setAuthenticated(bool isAuthenticated) async {
    final success = await sharedPreferences.setBool(
      AppConstants.isLoggedInKey,
      isAuthenticated,
    );
    if (!success) {
      // Failed to store authentication status
      throw const CacheException('Ops, problemas técnicos');
    }
  }

  @override
  Future<void> clearAuthData() async {
    await Future.wait([
      sharedPreferences.remove(AppConstants.totpSecretKey),
      sharedPreferences.remove(AppConstants.isLoggedInKey),
    ]);
  }
}
