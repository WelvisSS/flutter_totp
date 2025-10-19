import '../../domain/entities/auth_entities.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(LoginRequest request);
  Future<String> recoverSecret(RecoveryRequest request);
}
