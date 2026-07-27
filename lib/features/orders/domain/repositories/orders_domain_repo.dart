import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../../checkout/domain/entities/order_entity.dart';

abstract class OrdersDomainRepo {
  Future<Either<Failures, List<OrderEntity>>> getMyOrders();
}
