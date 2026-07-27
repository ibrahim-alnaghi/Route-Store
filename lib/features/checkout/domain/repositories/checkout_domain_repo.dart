import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../data/models/place_order_request_body.dart';
import '../entities/order_entity.dart';

abstract class CheckoutDomainRepo {
  Future<Either<Failures, OrderEntity>> placeOrder(
      PlaceOrderRequestBody body);
}
