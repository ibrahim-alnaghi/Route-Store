import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../data/models/login_model/login_request_body.dart';
import '../../data/models/reset_password_request_body.dart';
import '../../data/models/signup_model/signup_request_body.dart';
import '../entities/user_entity.dart';

abstract class AuthenticationDomainRepo {
  Future<Either<Failures, UserEntity>> login(LoginRequestBody loginRequestBody);
  Future<Either<Failures, UserEntity>> signup(
      SignupRequestBody signupRequestBody);
  Future<Either<Failures, String>> sendCode(String email);
  Future<Either<Failures, String>> verifyCode(String otpCode);
  Future<Either<Failures, String>> restPassword(ResetPasswordRequestBody body);
}
