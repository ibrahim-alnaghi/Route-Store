part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class SendCode extends ForgotPasswordEvent {
  @override
  List<Object> get props => [];
}

class VerifyCode extends ForgotPasswordEvent {
  final String otpCode;
  const VerifyCode(this.otpCode);
  @override
  List<Object> get props => [otpCode];
}

class ResetPassword extends ForgotPasswordEvent {
  @override
  List<Object> get props => [];
}

class TogglePasswordVisibility extends ForgotPasswordEvent {
  @override
  List<Object> get props => [];
}
