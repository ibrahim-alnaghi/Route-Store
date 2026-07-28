import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../core/constants/keys_constants.dart';
import '../../../../../core/local_storage/cache_helper.dart';
import '../../../../authentication/data/models/change_password_request_body.dart';
import '../../../../authentication/domain/usecases/change_password_use_case.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordStates> {
  final ChangePasswordUseCase _changePasswordUseCase;
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ChangePasswordBloc({required ChangePasswordUseCase changePasswordUseCase})
      : _changePasswordUseCase = changePasswordUseCase,
        super(const ChangePasswordStates(status: RequestStates.initial)) {
    on<SubmitChangePassword>((event, emit) async {
      await _submitChangePassword(emit);
    });
    on<ToggleCurrentPasswordVisibility>((event, emit) {
      emit(state.copyWith(showCurrentPassword: !state.showCurrentPassword));
    });
    on<ToggleNewPasswordVisibility>((event, emit) {
      emit(state.copyWith(showNewPassword: !state.showNewPassword));
    });
    on<ToggleConfirmPasswordVisibility>((event, emit) {
      emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
    });
  }

  Future<void> _submitChangePassword(Emitter<ChangePasswordStates> emit) async {
    emit(state.copyWith(status: RequestStates.loading));

    final result = await _changePasswordUseCase.call(
      ChangePasswordRequestBody(
        currentPassword: currentPassword.text,
        password: newPassword.text,
        rePassword: confirmPassword.text,
      ),
    );

    await result.fold(
      (l) async {
        emit(state.copyWith(
            status: RequestStates.failure, errorMessage: l.message));
      },
      (r) async {
        await CacheHelper.removeData(userkey);
        emit(state.copyWith(status: RequestStates.success));
      },
    );
  }

  @override
  Future<void> close() {
    currentPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    return super.close();
  }
}
