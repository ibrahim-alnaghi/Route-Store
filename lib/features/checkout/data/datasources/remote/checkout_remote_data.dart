import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_service.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/di/injection_container.dart';
import '../../../../authentication/domain/entities/user_entity.dart';
import '../../models/order_model.dart';
import '../../models/place_order_request_body.dart';
import '../checkout_data_source.dart';

@LazySingleton(as: CheckoutDataSource)
class CheckoutRemoteData implements CheckoutDataSource {
  final ApiService apiService;

  CheckoutRemoteData(this.apiService);

  @override
  Future<OrderModel> placeOrder(PlaceOrderRequestBody body) async {
    final data = await apiService.post(
      endPoint: '${EndPoints.orders}/${body.cartId}',
      data: body.toJson(),
      headers: {"token": getIt<UserEntity>().userToken},
    );
    return OrderModel.fromJson(data);
  }
}
