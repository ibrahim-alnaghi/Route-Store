import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/enums.dart';
import '../../../data/models/login_model/login_request_body.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/login_use_case.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStates> {
  final LoginUseCase _loginUseCase;
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  LoginBloc({required LoginUseCase loginUseCase})
      : _loginUseCase = loginUseCase,
        super(const LoginStates(status: RequestStates.initial)) {
    on<Login>((event, emit) async {
      await _login(emit);
    });

    on<TogglePasswordVisibility>((event, emit) {
      emit(state.copyWith(showPassword: !state.showPassword));
    });
  }

  Future<void> _login(Emitter<LoginStates> emit) async {
    emit(state.copyWith(status: RequestStates.loading));
    final body = LoginRequestBody(email: email.text, password: password.text);
    final result = await _loginUseCase.call(body);

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
