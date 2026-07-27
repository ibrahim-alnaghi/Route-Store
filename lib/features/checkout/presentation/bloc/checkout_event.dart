part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class PlaceOrder extends CheckoutEvent {
  final String cartId;
  final AdressEntity shippingAddress;

  const PlaceOrder({required this.cartId, required this.shippingAddress});

  @override
  List<Object?> get props => [cartId, shippingAddress];
}
