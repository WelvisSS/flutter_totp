import 'package:equatable/equatable.dart';

class AuthCredentials extends Equatable {
  final String username;
  final String password;

  const AuthCredentials({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class LoginRequest extends Equatable {
  final String username;
  final String password;
  final String totpCode;

  const LoginRequest({
    required this.username,
    required this.password,
    required this.totpCode,
  });

  @override
  List<Object> get props => [username, password, totpCode];
}

class RecoveryRequest extends Equatable {
  final String username;
  final String password;
  final String recoveryCode;

  const RecoveryRequest({
    required this.username,
    required this.password,
    required this.recoveryCode,
  });

  @override
  List<Object> get props => [username, password, recoveryCode];
}
