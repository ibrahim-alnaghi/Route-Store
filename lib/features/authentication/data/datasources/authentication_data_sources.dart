import '../../domain/entities/user_entity.dart';
import '../models/change_password_request_body.dart';
import '../models/login_model/login_model.dart';
import '../models/login_model/login_request_body.dart';
import '../models/reset_password_request_body.dart';
import '../models/signup_model/signup_model.dart';
import '../models/signup_model/signup_request_body.dart';
import '../models/update_profile_request_body.dart';

abstract class AuthenticationDataSources {
  Future<LoginModel> login(LoginRequestBody loginRequestBody);
  Future<SignupModel> signup(SignupRequestBody signupRequestBody);
  Future<String> sendCode(String email);
  Future<String> verifyCode(String otpCode);
  Future<String> restPassword(ResetPasswordRequestBody body);
  Future<UserEntity> updateProfile(UpdateProfileRequestBody body);
  Future<void> changePassword(ChangePasswordRequestBody body);
}
