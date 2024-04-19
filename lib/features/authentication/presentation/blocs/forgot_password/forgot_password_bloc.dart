import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/enums.dart';
import '../../../data/models/reset_password_request_body.dart';
import '../../../domain/usecases/rest_password_use_case.dart';
import '../../../domain/usecases/send_code_use_case.dart';
import '../../../domain/usecases/verify_code_use_case.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordStates> {
  final SendCodeUseCase _sendCodeUseCase;
  final VerifyCodeUseCase _verifyCodeUseCase;
  final RestPasswordUseCase _restPasswordUseCase;
  final email = TextEditingController();
  final newPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ForgotPasswordBloc(
      {required SendCodeUseCase sendCodeUseCase,
      required VerifyCodeUseCase verifyCodeUseCase,
      required RestPasswordUseCase restPasswordUseCase})
      : _sendCodeUseCase = sendCodeUseCase,
        _verifyCodeUseCase = verifyCodeUseCase,
        _restPasswordUseCase = restPasswordUseCase,
        super(const ForgotPasswordStates(status: RequestStates.initial)) {
    on<SendCode>((event, emit) async {
      await _sendCode(emit);
    });
    on<VerifyCode>((event, emit) async {
      await _verifyCode(emit, event.otpCode);
    });
    on<ResetPassword>((event, emit) async {
      await _resetPassword(emit);
    });
    on<TogglePasswordVisibility>((event, emit) {
      emit(state.copyWith(showPassword: !state.showPassword));
    });
  }
  Future<void> _sendCode(emit) async {
    emit(state.copyWith(status: RequestStates.loading));
    final result = await _sendCodeUseCase.call(email.text);

    result.fold(
      (l) {
        emit(state.copyWith(
            status: RequestStates.failure, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStates.success, successMessage: r));
      },
    );
  }

  Future<void> _verifyCode(emit, otpCode) async {
    emit(state.copyWith(status: RequestStates.loading));
    final result = await _verifyCodeUseCase.call(otpCode);

    result.fold(
      (l) {
        emit(state.copyWith(
            status: RequestStates.failure, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStates.success, successMessage: r));
      },
    );
  }

  Future<void> _resetPassword(emit) async {
    emit(state.copyWith(status: RequestStates.loading));
    final body = ResetPasswordRequestBody(
        email: email.text, newPassword: newPassword.text);
    final result = await _restPasswordUseCase.call(body);

    result.fold(
      (l) {
        emit(state.copyWith(
            status: RequestStates.failure, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStates.success, successMessage: r));
      },
    );
  }
}
