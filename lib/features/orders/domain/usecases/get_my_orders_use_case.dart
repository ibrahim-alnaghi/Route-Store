import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/no_param_use_case.dart';
import '../../../checkout/domain/entities/order_entity.dart';
import '../repositories/orders_domain_repo.dart';

@lazySingleton
class GetMyOrdersUseCase implements UseCase<List<OrderEntity>> {
  final OrdersDomainRepo ordersDomainRepo;

  GetMyOrdersUseCase(this.ordersDomainRepo);

  @override
  Future<Either<Failures, List<OrderEntity>>> call() =>
      ordersDomainRepo.getMyOrders();
}
