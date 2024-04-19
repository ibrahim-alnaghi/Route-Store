import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/no_param_use_case.dart';
import '../entities/category_entity/category_entity.dart';
import '../repositories/shop_domain_repo.dart';

@lazySingleton
class GetCategoriesUseCase implements UseCase<List<CategoryEntity>> {
  final ShopDomainRepo shopDomainRepo;

  GetCategoriesUseCase(this.shopDomainRepo);
  @override
  Future<Either<Failures, List<CategoryEntity>>> call(
          {Map<String, dynamic>? queryParameters}) =>
      shopDomainRepo.getCategories(queryParameters: queryParameters);
}
