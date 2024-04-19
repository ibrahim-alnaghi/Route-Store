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
}
