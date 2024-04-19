import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/no_param_use_case.dart';
import '../entities/product_entity/product_entity.dart';
import '../repositories/shop_domain_repo.dart';

@lazySingleton
class GetProductsUseCase implements UseCase<List<ProductEntity>> {
  final ShopDomainRepo shopDomainRepo;

  GetProductsUseCase(this.shopDomainRepo);
  @override
  Future<Either<Failures, List<ProductEntity>>> call(
          {Map<String, dynamic>? queryParameters}) =>
      shopDomainRepo.getProducts(queryParameters: queryParameters);
}
