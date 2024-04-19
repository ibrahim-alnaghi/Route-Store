class ResetPasswordRequestBody {
  final String email;
  final String newPassword;

  ResetPasswordRequestBody({required this.email, required this.newPassword});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'newPassword': newPassword,
    };
  }
}
