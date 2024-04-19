import 'package:equatable/equatable.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_products_entity.dart';

class CartItemsEntity extends Equatable {
  final String cartId;
  final List<CartProductsEntity> cartProducts;
  final num totalPrice;

  const CartItemsEntity(
      {required this.cartId,
      required this.cartProducts,
      required this.totalPrice});

  @override
  List<Object?> get props => [cartId, cartProducts, totalPrice];
}
