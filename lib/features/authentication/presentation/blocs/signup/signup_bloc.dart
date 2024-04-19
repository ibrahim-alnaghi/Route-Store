import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/enums.dart';
import '../../../data/models/signup_model%20/signup_request_body.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/sign_up_use_case.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupStates> {
  final SignupUseCase _signupUseCase;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final phone = TextEditingController();
  final formKey = GlobalKey<FormState>();
  SignupBloc({required SignupUseCase signupUseCase})
      : _signupUseCase = signupUseCase,
        super(const SignupStates(status: RequestStates.initial)) {
    on<SignUp>((event, emit) async {
      await _signUp(emit);
    });
    on<ToggleAgreedToTerms>((event, emit) {
      emit(state.copyWith(agreedToTerms: !state.agreedToTerms));
    });

    on<TogglePasswordVisibility>((event, emit) {
      emit(state.copyWith(showPassword: !state.showPassword));
    });
    on<ToggleConfirmPasswordVisibility>((event, emit) {
      emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
    });
  }
  Future<void> _signUp(emit) async {
    emit(state.copyWith(status: RequestStates.loading));
    final body = SignupRequestBody(
        name: '${firstName.text} ${lastName.text}',
        email: email.text,
        password: password.text,
        rePassword: confirmPassword.text,
        phone: phone.text);
    final result = await _signupUseCase.call(body);

    result.fold(
      (l) {
        emit(state.copyWith(
            status: RequestStates.failure, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStates.success, user: r));
      },
    );
  }
}
