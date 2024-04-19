import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/failures/server_failures.dart';
import '../../domain/entities/product_entity/product_entity.dart';
import '../../domain/repositories/shop_domain_repo.dart';
import '../datasources/shop_data_source.dart';
import '../models/brand_model/brand_model.dart';
import '../models/category_model/category_model.dart';
import '../models/product_model/product_model.dart';

@LazySingleton(as: ShopDomainRepo)
class ShopDataRepo implements ShopDomainRepo {
  final ShopDataSource shopDataSource;

  ShopDataRepo(this.shopDataSource);
  @override
  Future<Either<Failures, List<CategoryModel>>> getCategories(
      {Map<String, dynamic>? queryParameters}) async {
    try {
      List<CategoryModel> categories =
          await shopDataSource.getCategories(queryParameters: queryParameters);
      return Right(categories);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<BrandModel>>> getBrands(
      {Map<String, dynamic>? queryParameters}) async {
    try {
      List<BrandModel> brands =
          await shopDataSource.getBrands(queryParameters: queryParameters);
      return Right(brands);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<ProductModel>>> getProducts(
      {Map<String, dynamic>? queryParameters}) async {
    try {
      List<ProductModel> products =
          await shopDataSource.getProducts(queryParameters: queryParameters);
      return Right(products);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> addToFav(String productId) async {
    try {
      return Right(await shopDataSource.addToFav(productId));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> removeFromFav(String productId) async {
    try {
      return Right(await shopDataSource.removeFromFav(productId));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<ProductEntity>>> getFav() async {
    try {
      List<ProductModel> products = await shopDataSource.getFav();
      return Right(products);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }
}
