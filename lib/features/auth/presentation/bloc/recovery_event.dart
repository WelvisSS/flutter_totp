import 'package:equatable/equatable.dart';

abstract class RecoveryEvent extends Equatable {
  const RecoveryEvent();

  @override
  List<Object> get props => [];
}

/// Event triggered when user attempts to recover secret
class RecoverSecretRequested extends RecoveryEvent {
  final String username;
  final String password;
  final String recoveryCode;

  const RecoverSecretRequested({
    required this.username,
    required this.password,
    required this.recoveryCode,
  });

  @override
  List<Object> get props => [username, password, recoveryCode];
}
