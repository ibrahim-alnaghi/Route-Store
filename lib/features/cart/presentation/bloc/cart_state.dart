part of 'cart_bloc.dart';

class CartStates extends Equatable {
  final RequestStates status;
  final String? errorMessage;
  final CartEntity? cart;

  const CartStates({
    required this.status,
    this.errorMessage,
    this.cart,
  });

  CartStates copyWith(
      {RequestStates? status, String? errorMessage, CartEntity? cart}) {
    return CartStates(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      cart: cart ?? this.cart,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, cart];
}
