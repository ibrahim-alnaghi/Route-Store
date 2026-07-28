import '../../domain/entities/user_entity.dart';

class UpdateProfileModel extends UserEntity {
  const UpdateProfileModel(
      {required String currentToken,
      required String name,
      required String email})
      : super(
          userToken: currentToken,
          userName: name,
          userEmail: email,
        );

  factory UpdateProfileModel.fromJson(
      Map<String, dynamic> json, String currentToken) {
    final user = json['user'] as Map<String, dynamic>?;
    return UpdateProfileModel(
      currentToken: currentToken,
      name: user?['name'] as String? ?? '',
      email: user?['email'] as String? ?? '',
    );
  }
}
