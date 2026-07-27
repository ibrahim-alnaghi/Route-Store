import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:route_store/core/failures/failures.dart';
import 'package:route_store/core/usecases/param_use_case.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_entity.dart';
import 'package:route_store/features/cart/domain/repositories/cart_domain_repo.dart';

@lazySingleton
class ApplyCouponUseCase implements UseCase<CartEntity, String> {
  CartDomainRepo cartDomainRepo;
  ApplyCouponUseCase(this.cartDomainRepo);
  @override
  Future<Either<Failures, CartEntity>> call(String param) =>
      cartDomainRepo.applyCoupon(param);
}
