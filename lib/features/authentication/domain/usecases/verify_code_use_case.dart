import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/param_use_case.dart';
import '../repositories/authentication_domain_repo.dart';

@lazySingleton
class VerifyCodeUseCase implements UseCase<String, String> {
  AuthenticationDomainRepo loginDomainRepo;
  VerifyCodeUseCase(this.loginDomainRepo);
  @override
  Future<Either<Failures, String>> call(String param) =>
      loginDomainRepo.verifyCode(param);
}
