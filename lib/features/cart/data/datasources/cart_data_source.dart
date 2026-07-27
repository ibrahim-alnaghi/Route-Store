import 'package:route_store/features/cart/data/models/cart_model/cart_model.dart';

abstract class CartDataSource {
  Future<CartModel> getCart();
  Future<void> addProductToCart(String productId);
  Future<CartModel> applyCoupon(String couponCode);
  Future<void> updateCartProductQuantity(String productId, num quantity);
  Future<void> removeCartItem(String productId);
  Future<void> clearCart();
}
