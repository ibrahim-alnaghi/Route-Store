import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/no_param_use_case.dart';
import '../entities/brand_entity/brand_entity.dart';
import '../repositories/shop_domain_repo.dart';

@lazySingleton
class GetBrandsUseCase implements UseCase<List<BrandEntity>> {
  final ShopDomainRepo shopDomainRepo;

  GetBrandsUseCase(this.shopDomainRepo);
  @override
  Future<Either<Failures, List<BrandEntity>>> call(
          {Map<String, dynamic>? queryParameters}) =>
      shopDomainRepo.getBrands(queryParameters: queryParameters);
}
