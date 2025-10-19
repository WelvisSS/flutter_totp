import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/auth_entities.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(LoginRequest request);
  Future<Either<Failure, String>> recoverSecret(RecoveryRequest request);
  Future<Either<Failure, bool>> hasSecret();
  Future<Either<Failure, String>> getSecret();
  Future<Either<Failure, void>> storeSecret(String secret);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>> isAuthenticated();
}
