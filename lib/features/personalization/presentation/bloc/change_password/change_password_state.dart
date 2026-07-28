part of 'change_password_bloc.dart';

class ChangePasswordStates extends Equatable {
  final RequestStates status;
  final String? errorMessage;
  final bool showCurrentPassword;
  final bool showNewPassword;
  final bool showConfirmPassword;

  const ChangePasswordStates({
    required this.status,
    this.errorMessage,
    this.showCurrentPassword = false,
    this.showNewPassword = false,
    this.showConfirmPassword = false,
  });

  ChangePasswordStates copyWith({
    RequestStates? status,
    String? errorMessage,
    bool? showCurrentPassword,
    bool? showNewPassword,
    bool? showConfirmPassword,
  }) {
    return ChangePasswordStates(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      showCurrentPassword: showCurrentPassword ?? this.showCurrentPassword,
      showNewPassword: showNewPassword ?? this.showNewPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        showCurrentPassword,
        showNewPassword,
        showConfirmPassword,
      ];
}
