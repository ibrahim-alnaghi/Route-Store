import 'package:injectable/injectable.dart';

import '../../../../core/api/api_service.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/entities/user_entity.dart';
import '../models/change_password_request_body.dart';
import '../models/login_model/login_model.dart';
import '../models/login_model/login_request_body.dart';
import '../models/reset_password_request_body.dart';
import '../models/signup_model/signup_model.dart';
import '../models/signup_model/signup_request_body.dart';
import '../models/update_profile_model.dart';
import '../models/update_profile_request_body.dart';
import 'authentication_data_sources.dart';

@LazySingleton(as: AuthenticationDataSources)
class AuthenticationRemoteDataSources implements AuthenticationDataSources {
  final ApiService apiService;
  AuthenticationRemoteDataSources({
    required this.apiService,
  });

  @override
  Future<LoginModel> login(LoginRequestBody loginRequestBody) async {
    var data = await apiService.post(
        endPoint: EndPoints.login, data: loginRequestBody.toJson());
    LoginModel loginModel = LoginModel.fromJson(data);
    return loginModel;
  }

  @override
  Future<SignupModel> signup(SignupRequestBody signupRequestBody) async {
    var data = await apiService.post(
        endPoint: EndPoints.signUp, data: signupRequestBody.toJson());
    SignupModel signupModel = SignupModel.fromJson(data);
    return signupModel;
  }

  @override
  Future<String> sendCode(String email) async {
    await apiService.post(endPoint: EndPoints.sendCode, data: {'email': email});
    return 'code sent successfully';
  }

  @override
  Future<String> verifyCode(String otpCode) async {
    await apiService
        .post(endPoint: EndPoints.verifyCode, data: {'resetCode': otpCode});
    return 'successfully';
  }

  @override
  Future<String> restPassword(ResetPasswordRequestBody body) async {
    await apiService.put(endPoint: EndPoints.restPassword, data: body.toJson());
    return 'successfully';
  }

  @override
  Future<UserEntity> updateProfile(UpdateProfileRequestBody body) async {
    final currentToken = getIt<UserEntity>().userToken;
    final data = await apiService.put(
      endPoint: EndPoints.updateProfile,
      data: body.toJson(),
      headers: {"token": currentToken},
    );
    return UpdateProfileModel.fromJson(data, currentToken);
  }

  @override
  Future<void> changePassword(ChangePasswordRequestBody body) async {
    await apiService.put(
      endPoint: EndPoints.changePassword,
      data: body.toJson(),
      headers: {"token": getIt<UserEntity>().userToken},
    );
  }
}
