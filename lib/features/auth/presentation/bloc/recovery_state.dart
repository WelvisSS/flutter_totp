import 'package:equatable/equatable.dart';

abstract class RecoveryState extends Equatable {
  const RecoveryState();

  @override
  List<Object> get props => [];
}

/// Initial state for recovery
class RecoveryInitial extends RecoveryState {
  const RecoveryInitial();
}

/// State when recovery operation is in progress
class RecoveryLoading extends RecoveryState {
  const RecoveryLoading();
}

/// State when secret recovery is successful
class RecoverySuccess extends RecoveryState {
  const RecoverySuccess();
}

/// State when recovery operation fails
class RecoveryError extends RecoveryState {
  final String message;

  const RecoveryError(this.message);

  @override
  List<Object> get props => [message];
}
