import 'package:injectable/injectable.dart';
import 'package:route_store/core/constants/api_constants.dart';
import 'package:route_store/core/di/injection_container.dart';
import 'package:route_store/features/authentication/domain/entities/user_entity.dart';
import 'package:route_store/features/cart/data/models/cart_model/cart_model.dart';

import '../../../../../core/api/api_service.dart';

import '../cart_data_source.dart';

@LazySingleton(as: CartDataSource)
class PersonalizationRemoteData implements CartDataSource {
  final ApiService apiService;

  PersonalizationRemoteData(this.apiService);

  @override
  Future<CartModel> getCart() async {
    var data = await apiService.get(
      endPoint: EndPoints.cart,
      headers: {"token": getIt<UserEntity>().userToken},
    );
    CartModel cart = CartModel.fromJson(data);
    return cart;
  }

  @override
  Future<void> addProductToCart(String productId) async {
    await apiService.post(
      endPoint: EndPoints.cart,
      data: {'productId': productId},
      headers: {"token": getIt<UserEntity>().userToken},
    );
  }

  @override
  Future<CartModel> applyCoupon(String couponCode) async {
    final data = await apiService.put(
      endPoint: EndPoints.applyCoupon,
      data: {'couponName': couponCode},
      headers: {"token": getIt<UserEntity>().userToken},
    );
    return CartModel.fromJson(data);
  }

  @override
  Future<void> updateCartProductQuantity(String productId, num quantity) async {
    await apiService.put(
      endPoint: '${EndPoints.cart}/$productId',
      data: {'count': quantity},
      headers: {"token": getIt<UserEntity>().userToken},
    );
  }

  @override
  Future<void> removeCartItem(String productId) async {
    await apiService.delete(
      endPoint: '${EndPoints.cart}/$productId',
      headers: {"token": getIt<UserEntity>().userToken},
    );
  }

  @override
  Future<void> clearCart() async {
    await apiService.delete(
      endPoint: EndPoints.cart,
      headers: {"token": getIt<UserEntity>().userToken},
    );
  }
}
