import 'dart:convert';

import 'package:flutter_dev_test/core/errors/exceptions.dart';
import 'package:flutter_dev_test/features/auth/data/datasources/auth_remote_data_source_real.dart';
import 'package:flutter_dev_test/features/auth/data/models/user_model.dart';
import 'package:flutter_dev_test/features/auth/domain/entities/auth_entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../mocks/http_mock.mocks.dart';

void main() {
  late AuthRemoteDataSourceReal dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = AuthRemoteDataSourceReal(
      httpClient: mockHttpClient,
      baseUrl: 'http://test.com',
    );
  });

  group('AuthRemoteDataSourceReal', () {
    group('login', () {
      const tLoginRequest = LoginRequest(
        username: 'test@example.com',
        password: 'password123',
        totpCode: '123456',
      );

      const tUserModel = UserModel(
        username: 'test@example.com',
        isAuthenticated: true,
      );

      test('should return UserModel when login is successful (200)', () async {
        // arrange
        when(mockHttpClient.post(
          Uri.parse('http://test.com/auth/login'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'username': 'test@example.com',
            'password': 'password123',
            'totp_code': '123456',
          }),
        )).thenAnswer(
          (_) async => http.Response(
            json.encode({
              'user': 'test@example.com',
              'success': true,
            }),
            200,
          ),
        );

        // act
        final result = await dataSource.login(tLoginRequest);

        // assert
        expect(result, equals(tUserModel));
        verify(mockHttpClient.post(
          Uri.parse('http://test.com/auth/login'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'username': 'test@example.com',
            'password': 'password123',
            'totp_code': '123456',
          }),
        )).called(1);
      });

      test('should throw AuthException when login returns 401', () async {
        // arrange
        when(mockHttpClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer(
          (_) async => http.Response(
            json.encode({'error': 'Credenciais inválidas'}),
            401,
          ),
        );

        // act & assert
        expect(
          () => dataSource.login(tLoginRequest),
          throwsA(const TypeMatcher<AuthException>()),
        );
      });

      test('should throw ServerException when login returns 500', () async {
        // arrange
        when(mockHttpClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer(
          (_) async => http.Response(
            json.encode({'error': 'Internal server error'}),
            500,
          ),
        );

        // act & assert
        expect(
          () => dataSource.login(tLoginRequest),
          throwsA(const TypeMatcher<ServerException>()),
        );
      });

      test('should throw NetworkException when http client throws exception',
          () async {
        // arrange
        when(mockHttpClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenThrow(Exception('Network error'));

        // act & assert
        expect(
          () => dataSource.login(tLoginRequest),
          throwsA(const TypeMatcher<NetworkException>()),
        );
      });
    });

    group('recoverSecret', () {
      const tRecoveryRequest = RecoveryRequest(
        username: 'test@example.com',
        password: 'password123',
        recoveryCode: '123456',
      );

      const tSecret = 'ABCD1234EFGH5678';

      test('should return secret when recovery is successful (200)', () async {
        // arrange
        when(mockHttpClient.post(
          Uri.parse('http://test.com/auth/recovery-secret'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'username': 'test@example.com',
            'password': 'password123',
            'code': '123456',
          }),
        )).thenAnswer(
          (_) async => http.Response(
            json.encode({
              'totp_secret': tSecret,
            }),
            200,
          ),
        );

        // act
        final result = await dataSource.recoverSecret(tRecoveryRequest);

        // assert
        expect(result, equals(tSecret));
        verify(mockHttpClient.post(
          Uri.parse('http://test.com/auth/recovery-secret'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'username': 'test@example.com',
            'password': 'password123',
            'code': '123456',
          }),
        )).called(1);
      });

      test('should throw AuthException when recovery returns 401', () async {
        // arrange
        when(mockHttpClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer(
          (_) async => http.Response(
            json.encode({'error': 'Credenciais inválidas'}),
            401,
          ),
        );

        // act & assert
        expect(
          () => dataSource.recoverSecret(tRecoveryRequest),
          throwsA(const TypeMatcher<AuthException>()),
        );
      });

      test('should throw AuthException when recovery returns 404', () async {
        // arrange
        when(mockHttpClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer(
          (_) async => http.Response(
            json.encode({'message': 'Usuário não encontrado'}),
            404,
          ),
        );

        // act & assert
        expect(
          () => dataSource.recoverSecret(tRecoveryRequest),
          throwsA(const TypeMatcher<AuthException>()),
        );
      });

      test('should throw ServerException when recovery returns 500', () async {
        // arrange
        when(mockHttpClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer(
          (_) async => http.Response(
            json.encode({'error': 'Internal server error'}),
            500,
          ),
        );

        // act & assert
        expect(
          () => dataSource.recoverSecret(tRecoveryRequest),
          throwsA(const TypeMatcher<ServerException>()),
        );
      });

      test('should throw NetworkException when http client throws exception',
          () async {
        // arrange
        when(mockHttpClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenThrow(Exception('Network error'));

        // act & assert
        expect(
          () => dataSource.recoverSecret(tRecoveryRequest),
          throwsA(const TypeMatcher<NetworkException>()),
        );
      });
    });
  });
}
