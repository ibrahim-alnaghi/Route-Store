class ChangePasswordRequestBody {
  final String currentPassword;
  final String password;
  final String rePassword;

  ChangePasswordRequestBody(
      {required this.currentPassword,
      required this.password,
      required this.rePassword});

  Map<String, dynamic> toJson() {
    return {
      'currentPassword': currentPassword,
      'password': password,
      'rePassword': rePassword,
    };
  }
}
