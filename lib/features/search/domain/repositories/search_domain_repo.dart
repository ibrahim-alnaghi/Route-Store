import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../../shop/domain/entities/product_entity/product_entity.dart';

abstract class SearchDomainRepo {
  Future<Either<Failures, List<ProductEntity>>> searchProducts(
      {required String keyword});
}
