import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/constants/keys_constants.dart';

import '../../../../../core/local_storage/cache_helper.dart';

part 'personalization_event.dart';
part 'personalization_state.dart';

class PersonalizationBloc
    extends Bloc<PersonalizationEvent, PersonalizationStates> {
  PersonalizationBloc()
      : super(PersonalizationStates(
            isDark: CacheHelper.getData(darkThemeKey) ?? false)) {
    on<ChangeThemeMode>((event, emit) async {
      await changeThemeMode(emit);
    });
  }

  Future<void> changeThemeMode(Emitter<PersonalizationStates> emit) async {
    await CacheHelper.saveData(key: darkThemeKey, value: !state.isDark)
        .then((value) {
      if (value) {
        emit(state.copyWith(isDark: !state.isDark));
      }
    });
  }
}
