import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/param_use_case.dart';
import '../../data/models/update_profile_request_body.dart';
import '../entities/user_entity.dart';
import '../repositories/authentication_domain_repo.dart';

@lazySingleton
class UpdateProfileUseCase
    implements UseCase<UserEntity, UpdateProfileRequestBody> {
  AuthenticationDomainRepo authenticationDomainRepo;

  UpdateProfileUseCase(this.authenticationDomainRepo);

  @override
  Future<Either<Failures, UserEntity>> call(UpdateProfileRequestBody param) =>
      authenticationDomainRepo.updateProfile(param);
}
