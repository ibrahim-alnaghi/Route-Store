import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums.dart';
import '../../../checkout/domain/entities/order_entity.dart';
import '../../domain/usecases/get_my_orders_use_case.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetMyOrdersUseCase _getMyOrdersUseCase;

  OrdersBloc({required GetMyOrdersUseCase getMyOrdersUseCase})
      : _getMyOrdersUseCase = getMyOrdersUseCase,
        super(const OrdersState(status: RequestStates.initial)) {
    on<GetMyOrders>((event, emit) async {
      await _getMyOrders(emit);
    });
  }

  Future<void> _getMyOrders(Emitter<OrdersState> emit) async {
    emit(state.copyWith(status: RequestStates.loading));

    final result = await _getMyOrdersUseCase.call();

    result.fold(
      (l) {
        emit(state.copyWith(
            status: RequestStates.failure, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStates.success, orders: r));
      },
    );
  }
}
