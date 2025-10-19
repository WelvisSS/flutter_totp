import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class CheckSecretExists implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  const CheckSecretExists(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.hasSecret();
  }
}
