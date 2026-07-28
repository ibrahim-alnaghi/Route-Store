part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class SubmitChangePassword extends ChangePasswordEvent {}

class ToggleCurrentPasswordVisibility extends ChangePasswordEvent {}

class ToggleNewPasswordVisibility extends ChangePasswordEvent {}

class ToggleConfirmPasswordVisibility extends ChangePasswordEvent {}
