part of 'login_bloc.dart';

class LoginStates extends Equatable {
  final RequestStates status;
  final String? errorMessage;
  final UserEntity? user;

  final bool showPassword;

  const LoginStates({
    required this.status,
    this.errorMessage,
    this.user,
    this.showPassword = false,
  });

  LoginStates copyWith({
    RequestStates? status,
    String? errorMessage,
    UserEntity? user,
    bool? rememberMe,
    bool? showPassword,
  }) {
    return LoginStates(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      showPassword: showPassword ?? this.showPassword,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, showPassword];
}
