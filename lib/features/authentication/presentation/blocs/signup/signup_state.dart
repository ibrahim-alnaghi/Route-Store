part of 'signup_bloc.dart';

class SignupStates extends Equatable {
  final RequestStates status;
  final String? errorMessage;
  final UserEntity? user;
  final bool agreedToTerms;
  final bool showPassword;
  final bool showConfirmPassword;
  const SignupStates({
    required this.status,
    this.errorMessage,
    this.user,
    this.agreedToTerms = false,
    this.showPassword = false,
    this.showConfirmPassword = false,
  });

  SignupStates copyWith({
    RequestStates? status,
    String? errorMessage,
    UserEntity? user,
    bool? agreedToTerms,
    bool? showPassword,
    bool? showConfirmPassword,
  }) {
    return SignupStates(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      agreedToTerms: agreedToTerms ?? this.agreedToTerms,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
    );
  }

  @override
  List<Object?> get props =>
      [status, errorMessage, agreedToTerms, showPassword, showConfirmPassword];
}
