part of 'forgot_password_bloc.dart';

class ForgotPasswordStates extends Equatable {
  final RequestStates status;
  final String? errorMessage;
  final String? successMessage;
  final bool showPassword;
  const ForgotPasswordStates({
    required this.status,
    this.errorMessage,
    this.successMessage,
    this.showPassword = false,
  });

  ForgotPasswordStates copyWith({
    RequestStates? status,
    String? errorMessage,
    String? successMessage,
    bool? showPassword,
  }) {
    return ForgotPasswordStates(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      showPassword: showPassword ?? this.showPassword,
    );
  }

  @override
  List<Object?> get props =>
      [status, errorMessage, successMessage, showPassword];
}
