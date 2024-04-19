import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userToken;
  final String userName;
  final String userEmail;

  const UserEntity({
    required this.userToken,
    required this.userName,
    required this.userEmail,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      userToken: json['userToken'],
      userName: json['userName'],
      userEmail: json['userEmail'],
    );
  }

  @override
  List<Object?> get props => [
        userToken,
        userName,
        userEmail,
      ];

  Map<String, dynamic> toMap() {
    return {
      'userToken': userToken,
      'userName': userName,
      'userEmail': userEmail,
    };
  }
}
