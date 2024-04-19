import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:route_store/core/failures/failures.dart';
import 'package:route_store/core/usecases/no_param_use_case.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_entity.dart';
import 'package:route_store/features/cart/domain/repositories/cart_domain_repo.dart';

@lazySingleton
class GetCartUseCase implements UseCase<CartEntity> {
  CartDomainRepo cartDomainRepo;
  GetCartUseCase(this.cartDomainRepo);
  @override
  Future<Either<Failures, CartEntity>> call() => cartDomainRepo.getCart();
}
