import '../../domain/entities/adress_entity.dart';

class AdressModel extends AdressEntity {
  final String? id;
  final String? name;
  final String? details;
  final String? phone;
  final String? city;

  const AdressModel({this.id, this.name, this.details, this.phone, this.city})
      : super(
            adressID: id ?? '',
            adressName: name ?? '',
            adressDetails: details ?? '',
            adressPhone: phone ?? '',
            adressCity: city ?? '');

  factory AdressModel.fromJson(Map<String, dynamic> json) => AdressModel(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        details: json['details'] as String?,
        phone: json['phone'] as String?,
        city: json['city'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'details': details,
        'phone': phone,
        'city': city,
      };
}
