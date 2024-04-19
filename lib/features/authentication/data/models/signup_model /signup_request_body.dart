class SignupRequestBody {
  final String name;
  final String email;
  final String password;
  final String rePassword;
  final String phone;

  SignupRequestBody(
      {required this.name,
      required this.email,
      required this.password,
      required this.rePassword,
      required this.phone});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'rePassword': rePassword,
      'phone': phone,
    };
  }
}
