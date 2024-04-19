class AddAdressRequestBody {
  final String name;
  final String details;
  final String phone;
  final String city;

  AddAdressRequestBody({
    required this.name,
    required this.details,
    required this.phone,
    required this.city,
  });

  Map<String, dynamic> toJson() {
    return {"name": name, "details": details, "phone": phone, "city": city};
  }
}
