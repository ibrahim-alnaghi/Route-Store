import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_service.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/di/injection_container.dart';
import '../../../../../core/helpers/jwt_helper.dart';
import '../../../../authentication/domain/entities/user_entity.dart';
import '../../../../checkout/data/models/order_model.dart';
import '../orders_data_source.dart';

@LazySingleton(as: OrdersDataSource)
class OrdersRemoteData implements OrdersDataSource {
  final ApiService apiService;

  OrdersRemoteData(this.apiService);

  @override
  Future<List<OrderModel>> getMyOrders() async {
    final token = getIt<UserEntity>().userToken;
    final userId = JwtHelper.decodeUserId(token);
    if (userId == null) {
      throw Exception('Unable to resolve user id from token');
    }
    final data = await apiService.getList(
      endPoint: '${EndPoints.myOrders}/$userId',
      headers: {"token": token},
    );
    return data
        .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
