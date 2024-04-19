import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:route_store/core/failures/failures.dart';
import 'package:route_store/core/usecases/param_use_case.dart';
import 'package:route_store/features/cart/domain/repositories/cart_domain_repo.dart';

@lazySingleton
class AddProductToCart implements UseCase<void, String> {
  CartDomainRepo cartDomainRepo;
  AddProductToCart(this.cartDomainRepo);
  @override
  Future<Either<Failures, void>> call(String param) =>
      cartDomainRepo.addProductToCart(param);
}
