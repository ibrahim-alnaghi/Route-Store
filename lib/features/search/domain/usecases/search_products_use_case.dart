import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/param_use_case.dart';
import '../../../shop/domain/entities/product_entity/product_entity.dart';
import '../repositories/search_domain_repo.dart';

@lazySingleton
class SearchProductsUseCase implements UseCase<List<ProductEntity>, String> {
  final SearchDomainRepo searchDomainRepo;

  SearchProductsUseCase(this.searchDomainRepo);

  @override
  Future<Either<Failures, List<ProductEntity>>> call(String keyword) =>
      searchDomainRepo.searchProducts(keyword: keyword);
}
