import 'package:equatable/equatable.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_items.dart';

class CartEntity extends Equatable {
  final num cartItemsCount;
  final CartItemsEntity cartItems;

  const CartEntity({required this.cartItemsCount, required this.cartItems});

  @override
  List<Object?> get props => [cartItemsCount, cartItems];
}
