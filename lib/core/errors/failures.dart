import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final String message;

  const ServerFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => message;
}

class CacheFailure extends Failure {
  final String message;

  const CacheFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => message;
}

class NetworkFailure extends Failure {
  final String message;

  const NetworkFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => message;
}

class AuthFailure extends Failure {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => message;
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure() : super('Credenciais inválidas');
}

class InvalidRecoveryCodeFailure extends AuthFailure {
  const InvalidRecoveryCodeFailure() : super('Código inválido');
}

class SecretNotFoundFailure extends AuthFailure {
  const SecretNotFoundFailure() : super('Segredo TOTP não encontrado');
}

class InvalidTotpCodeFailure extends AuthFailure {
  const InvalidTotpCodeFailure() : super('Código TOTP inválido');
}
