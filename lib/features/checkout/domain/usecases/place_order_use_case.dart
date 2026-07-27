import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/param_use_case.dart';
import '../../data/models/place_order_request_body.dart';
import '../entities/order_entity.dart';
import '../repositories/checkout_domain_repo.dart';

@lazySingleton
class PlaceOrderUseCase implements UseCase<OrderEntity, PlaceOrderRequestBody> {
  final CheckoutDomainRepo checkoutDomainRepo;

  PlaceOrderUseCase(this.checkoutDomainRepo);

  @override
  Future<Either<Failures, OrderEntity>> call(PlaceOrderRequestBody param) =>
      checkoutDomainRepo.placeOrder(param);
}
