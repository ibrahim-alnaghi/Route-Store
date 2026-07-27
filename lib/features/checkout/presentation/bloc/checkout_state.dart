part of 'checkout_bloc.dart';

class CheckoutState extends Equatable {
  final RequestStates status;
  final OrderEntity? order;
  final String? errorMessage;

  const CheckoutState({required this.status, this.order, this.errorMessage});

  CheckoutState copyWith(
      {RequestStates? status, OrderEntity? order, String? errorMessage}) {
    return CheckoutState(
      status: status ?? this.status,
      order: order ?? this.order,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, order, errorMessage];
}
