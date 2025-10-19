import 'package:dartz/dartz.dart';
import 'package:flutter_dev_test/core/errors/failures.dart';
import 'package:flutter_dev_test/features/auth/domain/entities/auth_entities.dart';
import 'package:flutter_dev_test/features/auth/domain/usecases/recover_secret.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/auth_repository_mock.mocks.dart';

void main() {
  late RecoverSecret usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = RecoverSecret(mockAuthRepository);
  });

  group('RecoverSecret', () {
    const tUsername = 'test@example.com';
    const tPassword = 'password123';
    const tRecoveryCode = '123456';
    const tParams = RecoverSecretParams(
      username: tUsername,
      password: tPassword,
      recoveryCode: tRecoveryCode,
    );

    const tRecoveryRequest = RecoveryRequest(
      username: tUsername,
      password: tPassword,
      recoveryCode: tRecoveryCode,
    );

    const tSecret = 'ABCD1234EFGH5678';

    test(
        'should get secret from repository and store it when recovery is successful',
        () async {
      // arrange
      when(mockAuthRepository.recoverSecret(any))
          .thenAnswer((_) async => const Right(tSecret));
      when(mockAuthRepository.storeSecret(any))
          .thenAnswer((_) async => const Right(null));

      // act
      final result = await usecase(tParams);

      // assert
      expect(result, const Right(tSecret));
      verify(mockAuthRepository.recoverSecret(tRecoveryRequest));
      verify(mockAuthRepository.storeSecret(tSecret));
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return AuthFailure when repository returns AuthFailure',
        () async {
      // arrange
      const tFailure = AuthFailure('Código inválido');
      when(mockAuthRepository.recoverSecret(any))
          .thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await usecase(tParams);

      // assert
      expect(result, const Left(tFailure));
      verify(mockAuthRepository.recoverSecret(tRecoveryRequest));
      verifyNever(mockAuthRepository.storeSecret(any));
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return ServerFailure when repository returns ServerFailure',
        () async {
      // arrange
      const tFailure = ServerFailure('Server error');
      when(mockAuthRepository.recoverSecret(any))
          .thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await usecase(tParams);

      // assert
      expect(result, const Left(tFailure));
      verify(mockAuthRepository.recoverSecret(tRecoveryRequest));
      verifyNever(mockAuthRepository.storeSecret(any));
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return CacheFailure when storeSecret fails', () async {
      // arrange
      const tFailure = CacheFailure('Failed to store secret');
      when(mockAuthRepository.recoverSecret(any))
          .thenAnswer((_) async => const Right(tSecret));
      when(mockAuthRepository.storeSecret(any))
          .thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await usecase(tParams);

      // assert
      expect(result, const Left(tFailure));
      verify(mockAuthRepository.recoverSecret(tRecoveryRequest));
      verify(mockAuthRepository.storeSecret(tSecret));
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
