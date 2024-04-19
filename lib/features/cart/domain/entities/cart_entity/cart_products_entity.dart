import 'package:equatable/equatable.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_product_entity.dart';

class CartProductsEntity extends Equatable {
  final num itemCount;
  final String itemId;
  final CartProductEntity productDetails;
  final num itemPrice;

  const CartProductsEntity(
      {required this.itemCount,
      required this.itemId,
      required this.productDetails,
      required this.itemPrice});

  @override
  List<Object?> get props => [itemCount, itemId, productDetails, itemPrice];
}
