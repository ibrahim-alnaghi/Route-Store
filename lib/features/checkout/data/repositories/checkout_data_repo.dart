import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/failures/server_failures.dart';
import '../../domain/repositories/checkout_domain_repo.dart';
import '../datasources/checkout_data_source.dart';
import '../models/order_model.dart';
import '../models/place_order_request_body.dart';

@LazySingleton(as: CheckoutDomainRepo)
class CheckoutDataRepo implements CheckoutDomainRepo {
  final CheckoutDataSource checkoutDataSource;

  CheckoutDataRepo(this.checkoutDataSource);

  @override
  Future<Either<Failures, OrderModel>> placeOrder(
      PlaceOrderRequestBody body) async {
    try {
      return Right(await checkoutDataSource.placeOrder(body));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }
}
