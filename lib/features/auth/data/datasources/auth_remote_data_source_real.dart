import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/auth_entities.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceReal implements AuthRemoteDataSource {
  final http.Client httpClient;
  final String baseUrl;

  const AuthRemoteDataSourceReal({
    required this.httpClient,
    required this.baseUrl,
  });

  @override
  Future<UserModel> login(LoginRequest request) async {
    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': request.username,
          'password': request.password,
          'totp_code': request.totpCode,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserModel(
          username: data['user'] ?? request.username,
          isAuthenticated: true,
        );
      } else if (response.statusCode == 401) {
        throw const AuthException('Credenciais inválidas');
      } else {
        throw const ServerException('Ops. Tente novamente mais tarde.');
      }
    } catch (e) {
      if (e is AuthException || e is ServerException) {
        rethrow;
      }
      throw const NetworkException('Erro de conexão');
    }
  }

  @override
  Future<String> recoverSecret(RecoveryRequest request) async {
    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/auth/recovery-secret'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': request.username,
          'password': request.password,
          'code': request.recoveryCode,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['totp_secret'] ?? '';
      } else if (response.statusCode == 401) {
        throw const AuthException('Código inválido');
      } else if (response.statusCode == 404) {
        throw const AuthException('Usuário não encontrado');
      } else {
        throw const ServerException('Ops. Tente novamente mais tarde.');
      }
    } catch (e) {
      if (e is AuthException || e is ServerException) {
        rethrow;
      }
      throw const NetworkException('Erro de conexão');
    }
  }
}
