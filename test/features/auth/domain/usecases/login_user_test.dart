import 'package:dartz/dartz.dart';
import 'package:flutter_dev_test/core/errors/failures.dart';
import 'package:flutter_dev_test/features/auth/data/models/user_model.dart';
import 'package:flutter_dev_test/features/auth/domain/entities/auth_entities.dart';
import 'package:flutter_dev_test/features/auth/domain/usecases/login_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/auth_repository_mock.mocks.dart';

void main() {
  late LoginUser usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LoginUser(mockAuthRepository);
  });

  group('LoginUser', () {
    const tUsername = 'test@example.com';
    const tPassword = 'password123';
    const tTotpCode = '123456';
    const tParams = LoginParams(
      username: tUsername,
      password: tPassword,
      totpCode: tTotpCode,
    );

    const tLoginRequest = LoginRequest(
      username: tUsername,
      password: tPassword,
      totpCode: tTotpCode,
    );

    const tUser = UserModel(
      username: tUsername,
      isAuthenticated: true,
    );

    test('should get user from the repository when login is successful',
        () async {
      // arrange
      when(mockAuthRepository.login(any))
          .thenAnswer((_) async => const Right(tUser));

      // act
      final result = await usecase(tParams);

      // assert
      expect(result, const Right(tUser));
      verify(mockAuthRepository.login(tLoginRequest));
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return AuthFailure when repository returns AuthFailure',
        () async {
      // arrange
      const tFailure = AuthFailure('Credenciais inválidas');
      when(mockAuthRepository.login(any))
          .thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await usecase(tParams);

      // assert
      expect(result, const Left(tFailure));
      verify(mockAuthRepository.login(tLoginRequest));
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return ServerFailure when repository returns ServerFailure',
        () async {
      // arrange
      const tFailure = ServerFailure('Server error');
      when(mockAuthRepository.login(any))
          .thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await usecase(tParams);

      // assert
      expect(result, const Left(tFailure));
      verify(mockAuthRepository.login(tLoginRequest));
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
