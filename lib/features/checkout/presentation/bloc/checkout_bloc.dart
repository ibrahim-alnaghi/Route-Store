import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums.dart';
import '../../../personalization/domain/entities/adress_entity.dart';
import '../../data/models/place_order_request_body.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/place_order_use_case.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final PlaceOrderUseCase _placeOrderUseCase;

  CheckoutBloc({required PlaceOrderUseCase placeOrderUseCase})
      : _placeOrderUseCase = placeOrderUseCase,
        super(const CheckoutState(status: RequestStates.initial)) {
    on<PlaceOrder>((event, emit) async {
      await _placeOrder(event, emit);
    });
  }

  Future<void> _placeOrder(
      PlaceOrder event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(status: RequestStates.loading));

    final result = await _placeOrderUseCase.call(PlaceOrderRequestBody(
      cartId: event.cartId,
      details: event.shippingAddress.adressDetails,
      phone: event.shippingAddress.adressPhone,
      city: event.shippingAddress.adressCity,
    ));

    result.fold(
      (l) {
        emit(state.copyWith(
            status: RequestStates.failure, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStates.success, order: r));
      },
    );
  }
}
