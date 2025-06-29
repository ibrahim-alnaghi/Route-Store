import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/param_use_case.dart';
import '../../data/models/signup_model/signup_request_body.dart';
import '../entities/user_entity.dart';
import '../repositories/authentication_domain_repo.dart';

@lazySingleton
class SignupUseCase implements UseCase<UserEntity, SignupRequestBody> {
  AuthenticationDomainRepo loginDomainRepo;

  SignupUseCase(this.loginDomainRepo);

  @override
  Future<Either<Failures, UserEntity>> call(SignupRequestBody param) =>
      loginDomainRepo.signup(param);
}
