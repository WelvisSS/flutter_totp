import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/// Initial state when the app starts
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// State when authentication operation is in progress
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// State when user is successfully authenticated
class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

/// State when user is not authenticated
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// State when secret needs to be recovered
class AuthSecretRequired extends AuthState {
  const AuthSecretRequired();
}

/// State when an authentication error occurs
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
