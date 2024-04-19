import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopStates> {
  ShopBloc()
      : super(const ShopStates(
          selectedIndex: 0,
        )) {
    on<SelectNavigationEvent>((event, emit) {
      emit(ShopStates(
        selectedIndex: event.selectedIndex,
      ));
    });
  }
}
