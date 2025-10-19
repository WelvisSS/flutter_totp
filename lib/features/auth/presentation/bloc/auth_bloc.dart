import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/totp_generator.dart';
import '../../domain/usecases/check_secret_exists.dart';
import '../../domain/usecases/get_secret.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/logout_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final CheckSecretExists checkSecretExists;
  final GetSecret getSecret;
  final LogoutUser logoutUser;

  AuthBloc({
    required this.loginUser,
    required this.checkSecretExists,
    required this.getSecret,
    required this.logoutUser,
  }) : super(const AuthInitial()) {
    on<CheckSecretRequested>(_onCheckSecretRequested);
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onCheckSecretRequested(
    CheckSecretRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await checkSecretExists(NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (hasSecret) {
        if (hasSecret) {
          emit(const AuthUnauthenticated());
        } else {
          emit(const AuthSecretRequired());
        }
      },
    );
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    // First check if secret exists
    final secretResult = await checkSecretExists(NoParams());

    await secretResult.fold(
      (failure) async => emit(AuthError(failure.toString())),
      (hasSecret) async {
        if (!hasSecret) {
          // No secret exists, redirect to recovery
          emit(const AuthSecretRequired());
          return;
        }

        final getSecretResult = await getSecret(NoParams());

        await getSecretResult.fold(
          (failure) async => emit(AuthError(failure.toString())),
          (secret) async {
            // Generate TOTP code
            final totpCode = TotpGenerator.generateTOTP(secret);

            // Attempt login with credentials and TOTP
            final loginResult = await loginUser(LoginParams(
              username: event.username,
              password: event.password,
              totpCode: totpCode,
            ));

            loginResult.fold(
              (failure) {
                // Check if it's invalid credentials failure
                if (failure is AuthFailure) {
                  emit(const AuthError('Credenciais inválidas'));
                } else {
                  emit(AuthError(failure.toString()));
                }
              },
              (user) => emit(AuthAuthenticated(user)),
            );
          },
        );
      },
    );
  }
}
