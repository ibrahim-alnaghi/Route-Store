import 'package:dartz/dartz.dart';
import 'package:route_store/core/failures/failures.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_entity.dart';

abstract class CartDomainRepo {
  Future<Either<Failures, CartEntity>> getCart();
  Future<Either<Failures, void>> addProductToCart(String productId);
}
