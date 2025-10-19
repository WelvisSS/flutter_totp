import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/recover_secret.dart';
import 'recovery_event.dart';
import 'recovery_state.dart';

class RecoveryBloc extends Bloc<RecoveryEvent, RecoveryState> {
  final RecoverSecret recoverSecret;

  RecoveryBloc({
    required this.recoverSecret,
  }) : super(const RecoveryInitial()) {
    on<RecoverSecretRequested>(_onRecoverSecretRequested);
  }

  Future<void> _onRecoverSecretRequested(
    RecoverSecretRequested event,
    Emitter<RecoveryState> emit,
  ) async {
    emit(const RecoveryLoading());

    final result = await recoverSecret(RecoverSecretParams(
      username: event.username,
      password: event.password,
      recoveryCode: event.recoveryCode,
    ));

    result.fold(
      (failure) => emit(RecoveryError(failure.toString())),
      (_) => emit(const RecoverySuccess()),
    );
  }
}
