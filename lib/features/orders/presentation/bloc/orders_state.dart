part of 'orders_bloc.dart';

class OrdersState extends Equatable {
  final RequestStates status;
  final List<OrderEntity>? orders;
  final String? errorMessage;

  const OrdersState({required this.status, this.orders, this.errorMessage});

  OrdersState copyWith(
      {RequestStates? status,
      List<OrderEntity>? orders,
      String? errorMessage}) {
    return OrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, orders, errorMessage];
}
