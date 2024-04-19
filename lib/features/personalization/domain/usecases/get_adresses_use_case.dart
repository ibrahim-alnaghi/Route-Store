import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../entities/adress_entity.dart';
import '../repositories/personalization_domain_repo.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/no_param_use_case.dart';

@lazySingleton
class GetAdressesUseCase implements UseCase<List<AdressEntity>> {
  final PersonalizationDomainRepo personalizationDomainRepo;

  GetAdressesUseCase(this.personalizationDomainRepo);
  @override
  Future<Either<Failures, List<AdressEntity>>> call() =>
      personalizationDomainRepo.getAdresses();
}
