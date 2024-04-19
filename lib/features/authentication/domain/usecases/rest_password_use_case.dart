import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/param_use_case.dart';
import '../../data/models/reset_password_request_body.dart';
import '../repositories/authentication_domain_repo.dart';

@lazySingleton
class RestPasswordUseCase implements UseCase<String, ResetPasswordRequestBody> {
  AuthenticationDomainRepo loginDomainRepo;
  RestPasswordUseCase(this.loginDomainRepo);
  @override
  Future<Either<Failures, String>> call(ResetPasswordRequestBody param) =>
      loginDomainRepo.restPassword(param);
}
