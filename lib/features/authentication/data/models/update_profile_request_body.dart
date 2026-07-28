class UpdateProfileRequestBody {
  final String name;
  final String email;

  UpdateProfileRequestBody({required this.name, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}
