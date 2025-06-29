import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/failures/server_failures.dart';
import '../../domain/repositories/authentication_domain_repo.dart';
import '../datasources/authentication_data_sources.dart';
import '../models/login_model/login_model.dart';
import '../models/login_model/login_request_body.dart';
import '../models/reset_password_request_body.dart';
import '../models/signup_model/signup_model.dart';
import '../models/signup_model/signup_request_body.dart';

@LazySingleton(as: AuthenticationDomainRepo)
class AuthenticationDataRepo implements AuthenticationDomainRepo {
  AuthenticationDataSources loginDataSources;

  AuthenticationDataRepo(this.loginDataSources);

  @override
  Future<Either<Failures, LoginModel>> login(
      LoginRequestBody loginRequestBody) async {
    try {
      LoginModel loginModel = await loginDataSources.login(loginRequestBody);
      return Right(loginModel);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, SignupModel>> signup(
      SignupRequestBody signupRequestBody) async {
    try {
      SignupModel signupModel =
          await loginDataSources.signup(signupRequestBody);
      return Right(signupModel);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> sendCode(String email) async {
    try {
      return Right(await loginDataSources.sendCode(email));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> verifyCode(String otpCode) async {
    try {
      return Right(await loginDataSources.verifyCode(otpCode));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> restPassword(
      ResetPasswordRequestBody body) async {
    try {
      return Right(await loginDataSources.restPassword(body));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }
}
