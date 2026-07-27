import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/failures/server_failures.dart';
import '../../../checkout/data/models/order_model.dart';
import '../../domain/repositories/orders_domain_repo.dart';
import '../datasources/orders_data_source.dart';

@LazySingleton(as: OrdersDomainRepo)
class OrdersDataRepo implements OrdersDomainRepo {
  final OrdersDataSource ordersDataSource;

  OrdersDataRepo(this.ordersDataSource);

  @override
  Future<Either<Failures, List<OrderModel>>> getMyOrders() async {
    try {
      return Right(await ordersDataSource.getMyOrders());
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }
}
