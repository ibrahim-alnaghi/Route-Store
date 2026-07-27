import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/failures/server_failures.dart';
import '../../../shop/domain/entities/product_entity/product_entity.dart';
import '../../domain/repositories/search_domain_repo.dart';
import '../datasources/search_data_source.dart';

@LazySingleton(as: SearchDomainRepo)
class SearchDataRepo implements SearchDomainRepo {
  final SearchDataSource searchDataSource;

  SearchDataRepo(this.searchDataSource);

  @override
  Future<Either<Failures, List<ProductEntity>>> searchProducts(
      {required String keyword}) async {
    try {
      final products = await searchDataSource.searchProducts(keyword: keyword);
      return Right(products);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }
}
