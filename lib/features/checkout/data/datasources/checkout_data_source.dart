import '../models/order_model.dart';
import '../models/place_order_request_body.dart';

abstract class CheckoutDataSource {
  Future<OrderModel> placeOrder(PlaceOrderRequestBody body);
}
