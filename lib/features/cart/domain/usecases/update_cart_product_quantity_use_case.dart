import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:route_store/core/failures/failures.dart';
import 'package:route_store/core/usecases/param_use_case.dart';
import 'package:route_store/features/cart/domain/repositories/cart_domain_repo.dart';

class UpdateCartQuantityParams extends Equatable {
  final String productId;
  final num quantity;

  const UpdateCartQuantityParams(
      {required this.productId, required this.quantity});

  @override
  List<Object?> get props => [productId, quantity];
}

@lazySingleton
class UpdateCartProductQuantityUseCase
    implements UseCase<void, UpdateCartQuantityParams> {
  CartDomainRepo cartDomainRepo;
  UpdateCartProductQuantityUseCase(this.cartDomainRepo);
  @override
  Future<Either<Failures, void>> call(UpdateCartQuantityParams param) =>
      cartDomainRepo.updateCartProductQuantity(param.productId, param.quantity);
}
