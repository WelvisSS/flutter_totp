import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/auth_entities.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> login(LoginRequest request) async {
    try {
      final user = await remoteDataSource.login(request);
      await localDataSource.setAuthenticated(true);
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      //Unexpected error occurred during login
      return const Left(ServerFailure('Ops, tente novamente mais tarde.'));
    }
  }

  @override
  Future<Either<Failure, String>> recoverSecret(RecoveryRequest request) async {
    try {
      final secret = await remoteDataSource.recoverSecret(request);
      return Right(secret);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      //Unexpected error occurred during secret recovery
      return const Left(ServerFailure('Ops, tente novamente mais tarde.'));
    }
  }

  @override
  Future<Either<Failure, bool>> hasSecret() async {
    try {
      final hasSecret = await localDataSource.hasSecret();
      return Right(hasSecret);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      //Failed to check secret existence
      return const Left(CacheFailure('Ops, tente novamente mais tarde.'));
    }
  }

  @override
  Future<Either<Failure, String>> getSecret() async {
    try {
      final secret = await localDataSource.getSecret();
      return Right(secret);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      //Failed to retrieve secret
      return const Left(CacheFailure('Ops, tente novamente mais tarde.'));
    }
  }

  @override
  Future<Either<Failure, void>> storeSecret(String secret) async {
    try {
      await localDataSource.storeSecret(secret);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      //Failed to store secret
      return const Left(CacheFailure('Ops, tente novamente mais tarde.'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearAuthData();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      //Failed to clear authentication data
      return const Left(CacheFailure('Ops, tente novamente mais tarde.'));
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final isAuthenticated = await localDataSource.isAuthenticated();
      return Right(isAuthenticated);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      //Failed to check authentication status
      return const Left(CacheFailure('Ops, tente novamente mais tarde.'));
    }
  }
}
