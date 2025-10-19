import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_entities.dart';
import '../repositories/auth_repository.dart';

class RecoverSecret implements UseCase<String, RecoverSecretParams> {
  final AuthRepository repository;

  const RecoverSecret(this.repository);

  @override
  Future<Either<Failure, String>> call(RecoverSecretParams params) async {
    final recoveryRequest = RecoveryRequest(
      username: params.username,
      password: params.password,
      recoveryCode: params.recoveryCode,
    );

    final result = await repository.recoverSecret(recoveryRequest);

    return result.fold(
      (failure) => Left(failure),
      (secret) async {
        final storeResult = await repository.storeSecret(secret);
        return storeResult.fold(
          (failure) => Left(failure),
          (_) => Right(secret),
        );
      },
    );
  }
}

class RecoverSecretParams extends Equatable {
  final String username;
  final String password;
  final String recoveryCode;

  const RecoverSecretParams({
    required this.username,
    required this.password,
    required this.recoveryCode,
  });

  @override
  List<Object> get props => [username, password, recoveryCode];
}
