import '../../../domain/entities/user_entity.dart';
import 'user.dart';

class SignupModel extends UserEntity {
  final String? message;
  final User? user;
  final String? token;

  SignupModel({this.message, this.user, this.token})
      : super(
            userToken: token ?? '',
            userName: user?.name ?? '',
            userEmail: user?.email ?? '');

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
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
