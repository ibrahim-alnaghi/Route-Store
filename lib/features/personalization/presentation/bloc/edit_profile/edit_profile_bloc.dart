import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../core/constants/keys_constants.dart';
import '../../../../../core/di/injection_container.dart';
import '../../../../../core/local_storage/cache_helper.dart';
import '../../../../authentication/data/models/update_profile_request_body.dart';
import '../../../../authentication/domain/entities/user_entity.dart';
import '../../../../authentication/domain/usecases/update_profile_use_case.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileStates> {
  final UpdateProfileUseCase _updateProfileUseCase;
  final name = TextEditingController(text: getIt<UserEntity>().userName);
  final email = TextEditingController(text: getIt<UserEntity>().userEmail);
  final formKey = GlobalKey<FormState>();

  EditProfileBloc({required UpdateProfileUseCase updateProfileUseCase})
      : _updateProfileUseCase = updateProfileUseCase,
        super(const EditProfileStates(status: RequestStates.initial)) {
    on<SubmitUpdateProfile>((event, emit) async {
      await _submitUpdateProfile(emit);
    });
  }

  Future<void> _submitUpdateProfile(Emitter<EditProfileStates> emit) async {
    emit(state.copyWith(status: RequestStates.loading));

    final result = await _updateProfileUseCase.call(
      UpdateProfileRequestBody(
        name: name.text.trim(),
        email: email.text.trim(),
      ),
    );

    await result.fold(
      (l) async {
        emit(state.copyWith(
            status: RequestStates.failure, errorMessage: l.message));
      },
      (r) async {
        await CacheHelper.saveData(key: userkey, value: r.toMap());
        emit(state.copyWith(status: RequestStates.success));
      },
    );
  }

  @override
  Future<void> close() {
    name.dispose();
    email.dispose();
    return super.close();
  }
}
