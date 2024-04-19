part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCart extends CartEvent {}

class AddToCart extends CartEvent {
  final String productId;

  const AddToCart(this.productId);

  @override
  List<Object> get props => [productId];
}

class UpdateCartProductQuantity extends CartEvent {
  final String productId;
  final num quantity;

  const UpdateCartProductQuantity(this.productId, this.quantity);

  @override
  List<Object> get props => [productId, quantity];
}

class RemoveCartItem extends CartEvent {
  final String productId;

  const RemoveCartItem(this.productId);

  @override
  List<Object> get props => [productId];
}

class ClearCart extends CartEvent {}
