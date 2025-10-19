import 'package:dartz/dartz.dart';
import 'package:flutter_dev_test/core/errors/exceptions.dart';
import 'package:flutter_dev_test/core/errors/failures.dart';
import 'package:flutter_dev_test/features/auth/data/models/user_model.dart';
import 'package:flutter_dev_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_dev_test/features/auth/domain/entities/auth_entities.dart';
import 'package:flutter_dev_test/features/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/auth_datasources_mock.mocks.dart';

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('AuthRepositoryImpl', () {
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

      test('should return User when login is successful', () async {
        // arrange
        when(mockRemoteDataSource.login(any))
            .thenAnswer((_) async => tUserModel);
        when(mockLocalDataSource.setAuthenticated(any))
            .thenAnswer((_) async => {});

        // act
        final result = await repository.login(tLoginRequest);

        // assert
        expect(result, equals(const Right<Failure, User>(tUserModel)));
        verify(mockRemoteDataSource.login(tLoginRequest)).called(1);
        verify(mockLocalDataSource.setAuthenticated(true)).called(1);
      });

      test('should return AuthFailure when AuthException is thrown', () async {
        // arrange
        const tException = AuthException('Credenciais inválidas');
        when(mockRemoteDataSource.login(any)).thenThrow(tException);

        // act
        final result = await repository.login(tLoginRequest);

        // assert
        expect(
            result,
            equals(const Left<Failure, User>(
                AuthFailure('Credenciais inválidas'))));
        verify(mockRemoteDataSource.login(tLoginRequest)).called(1);
        verifyNever(mockLocalDataSource.setAuthenticated(any));
      });

      test('should return ServerFailure when ServerException is thrown',
          () async {
        // arrange
        const tException = ServerException('Server error');
        when(mockRemoteDataSource.login(any)).thenThrow(tException);

        // act
        final result = await repository.login(tLoginRequest);

        // assert
        expect(result,
            equals(const Left<Failure, User>(ServerFailure('Server error'))));
        verify(mockRemoteDataSource.login(tLoginRequest)).called(1);
        verifyNever(mockLocalDataSource.setAuthenticated(any));
      });

      test('should return ServerFailure when unexpected exception is thrown',
          () async {
        // arrange
        when(mockRemoteDataSource.login(any))
            .thenThrow(Exception('Unexpected error'));

        // act
        final result = await repository.login(tLoginRequest);

        // assert
        expect(
            result,
            equals(const Left<Failure, User>(
                ServerFailure('Ops, tente novamente mais tarde.'))));
        verify(mockRemoteDataSource.login(tLoginRequest)).called(1);
        verifyNever(mockLocalDataSource.setAuthenticated(any));
      });
    });

    group('recoverSecret', () {
      const tRecoveryRequest = RecoveryRequest(
        username: 'test@example.com',
        password: 'password123',
        recoveryCode: '123456',
      );

      const tSecret = 'ABCD1234EFGH5678';

      test('should return secret when recovery is successful', () async {
        // arrange
        when(mockRemoteDataSource.recoverSecret(any))
            .thenAnswer((_) async => tSecret);

        // act
        final result = await repository.recoverSecret(tRecoveryRequest);

        // assert
        expect(result, equals(const Right<Failure, String>(tSecret)));
        verify(mockRemoteDataSource.recoverSecret(tRecoveryRequest)).called(1);
      });

      test('should return AuthFailure when AuthException is thrown', () async {
        // arrange
        const tException = AuthException('Código inválido');
        when(mockRemoteDataSource.recoverSecret(any)).thenThrow(tException);

        // act
        final result = await repository.recoverSecret(tRecoveryRequest);

        // assert
        expect(
            result,
            equals(
                const Left<Failure, String>(AuthFailure('Código inválido'))));
        verify(mockRemoteDataSource.recoverSecret(tRecoveryRequest)).called(1);
      });

      test('should return ServerFailure when ServerException is thrown',
          () async {
        // arrange
        const tException = ServerException('Server error');
        when(mockRemoteDataSource.recoverSecret(any)).thenThrow(tException);

        // act
        final result = await repository.recoverSecret(tRecoveryRequest);

        // assert
        expect(result,
            equals(const Left<Failure, String>(ServerFailure('Server error'))));
        verify(mockRemoteDataSource.recoverSecret(tRecoveryRequest)).called(1);
      });

      test('should return ServerFailure when unexpected exception is thrown',
          () async {
        // arrange
        when(mockRemoteDataSource.recoverSecret(any))
            .thenThrow(Exception('Unexpected error'));

        // act
        final result = await repository.recoverSecret(tRecoveryRequest);

        // assert
        expect(
            result,
            equals(const Left<Failure, String>(
                ServerFailure('Ops, tente novamente mais tarde.'))));
        verify(mockRemoteDataSource.recoverSecret(tRecoveryRequest)).called(1);
      });
    });
  });
}
