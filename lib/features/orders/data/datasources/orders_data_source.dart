import '../../../checkout/data/models/order_model.dart';

abstract class OrdersDataSource {
  Future<List<OrderModel>> getMyOrders();
}
