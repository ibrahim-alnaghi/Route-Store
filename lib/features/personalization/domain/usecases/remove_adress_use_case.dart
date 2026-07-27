import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../repositories/personalization_domain_repo.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/param_use_case.dart';

@lazySingleton
class RemoveAdressUseCase implements UseCase<void, String> {
  PersonalizationDomainRepo personalizationDomainRepo;
  RemoveAdressUseCase(this.personalizationDomainRepo);
  @override
  Future<Either<Failures, void>> call(String param) =>
      personalizationDomainRepo.removeAdress(param);
}
