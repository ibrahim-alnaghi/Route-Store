import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/add_adress_request_body.dart';
import '../repositories/personalization_domain_repo.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/param_use_case.dart';

@lazySingleton
class AddAdressUseCase implements UseCase<void, AddAdressRequestBody> {
  PersonalizationDomainRepo personalizationDomainRepo;
  AddAdressUseCase(this.personalizationDomainRepo);
  @override
  Future<Either<Failures, void>> call(AddAdressRequestBody param) =>
      personalizationDomainRepo.addAdress(param);
}
