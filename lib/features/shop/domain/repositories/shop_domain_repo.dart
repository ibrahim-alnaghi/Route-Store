import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../entities/brand_entity/brand_entity.dart';
import '../entities/category_entity/category_entity.dart';
import '../entities/product_entity/product_entity.dart';

abstract class ShopDomainRepo {
  Future<Either<Failures, List<CategoryEntity>>> getCategories(
      {Map<String, dynamic>? queryParameters});
  Future<Either<Failures, List<BrandEntity>>> getBrands(
      {Map<String, dynamic>? queryParameters});
  Future<Either<Failures, List<ProductEntity>>> getProducts(
      {Map<String, dynamic>? queryParameters});
  Future<Either<Failures, List<ProductEntity>>> getFav();
  Future<Either<Failures, void>> addToFav(String productId);
  Future<Either<Failures, void>> removeFromFav(String productId);
}
