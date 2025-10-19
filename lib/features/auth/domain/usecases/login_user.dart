import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_entities.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUser implements UseCase<User, LoginParams> {
  final AuthRepository repository;

  const LoginUser(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    final loginRequest = LoginRequest(
      username: params.username,
      password: params.password,
      totpCode: params.totpCode,
    );

    return await repository.login(loginRequest);
  }
}

class LoginParams extends Equatable {
  final String username;
  final String password;
  final String totpCode;

  const LoginParams({
    required this.username,
    required this.password,
    required this.totpCode,
  });

  @override
  List<Object> get props => [username, password, totpCode];
}
