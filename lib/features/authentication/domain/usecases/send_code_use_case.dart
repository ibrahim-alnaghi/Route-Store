import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/param_use_case.dart';
import '../repositories/authentication_domain_repo.dart';

@lazySingleton
class SendCodeUseCase implements UseCase<String, String> {
  AuthenticationDomainRepo loginDomainRepo;
  SendCodeUseCase(this.loginDomainRepo);
  @override
  Future<Either<Failures, String>> call(String param) =>
      loginDomainRepo.sendCode(param);
}
