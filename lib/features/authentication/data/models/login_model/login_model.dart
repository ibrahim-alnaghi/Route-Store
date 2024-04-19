import '../../../domain/entities/user_entity.dart';
import 'user.dart';

class LoginModel extends UserEntity {
  final String? message;
  final User? user;
  final String? token;

  LoginModel({this.message, this.user, this.token})
      : super(
            userToken: token ?? '',
            userName: user?.name ?? '',
            userEmail: user?.email ?? '');

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json['message'] as String?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'user': user?.toJson(),
        'token': token,
      };
}
