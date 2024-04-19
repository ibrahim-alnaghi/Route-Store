part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignUp extends SignupEvent {
  @override
  List<Object> get props => [];
}

class ToggleAgreedToTerms extends SignupEvent {
  @override
  List<Object> get props => [];
}

class TogglePasswordVisibility extends SignupEvent {
  @override
  List<Object> get props => [];
}

class ToggleConfirmPasswordVisibility extends SignupEvent {
  @override
  List<Object> get props => [];
}
