import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/param_use_case.dart';
import '../repositories/shop_domain_repo.dart';

@lazySingleton
class RemoveFromFavUseCase implements UseCase<void, String> {
  final ShopDomainRepo shopDomainRepo;

  RemoveFromFavUseCase(this.shopDomainRepo);
  @override
  Future<Either<Failures, void>> call(String param) =>
      shopDomainRepo.removeFromFav(param);
}
