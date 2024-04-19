import 'package:route_store/features/cart/data/models/cart_model/cart_model.dart';

abstract class CartDataSource {
  Future<CartModel> getCart();
  Future<void> addProductToCart(String productId);
}
