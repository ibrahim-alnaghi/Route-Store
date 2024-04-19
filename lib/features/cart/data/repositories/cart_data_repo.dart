import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:route_store/core/failures/failures.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/cart/data/datasources/cart_data_source.dart';
import 'package:route_store/features/cart/data/models/cart_model/cart_model.dart';
import 'package:route_store/features/cart/domain/repositories/cart_domain_repo.dart';

@LazySingleton(as: CartDomainRepo)
class CartDataRepo implements CartDomainRepo {
  CartDataSource cartDataSource;
  CartDataRepo(this.cartDataSource);
  @override
  Future<Either<Failures, CartModel>> getCart() async {
    try {
      CartModel cart = await cartDataSource.getCart();
      return Right(cart);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> addProductToCart(String productId) async {
    try {
      return Right(await cartDataSource.addProductToCart(productId));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }
}
