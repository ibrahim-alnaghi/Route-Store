import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/param_use_case.dart';
import '../../data/models/change_password_request_body.dart';
import '../repositories/authentication_domain_repo.dart';

@lazySingleton
class ChangePasswordUseCase
    implements UseCase<void, ChangePasswordRequestBody> {
  AuthenticationDomainRepo authenticationDomainRepo;

  ChangePasswordUseCase(this.authenticationDomainRepo);

  @override
  Future<Either<Failures, void>> call(ChangePasswordRequestBody param) =>
      authenticationDomainRepo.changePassword(param);
}
