import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/param_use_case.dart';
import '../../data/models/login_model/login_request_body.dart';
import '../entities/user_entity.dart';
import '../repositories/authentication_domain_repo.dart';

@lazySingleton
class LoginUseCase implements UseCase<UserEntity, LoginRequestBody> {
  AuthenticationDomainRepo loginDomainRepo;

  LoginUseCase(this.loginDomainRepo);

  @override
  Future<Either<Failures, UserEntity>> call(LoginRequestBody param) =>
      loginDomainRepo.login(param);
}
