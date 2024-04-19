import 'package:equatable/equatable.dart';

class AdressEntity extends Equatable {
  final String adressID;
  final String adressName;
  final String adressDetails;
  final String adressPhone;
  final String adressCity;

  const AdressEntity(
      {required this.adressID,
      required this.adressName,
      required this.adressDetails,
      required this.adressPhone,
      required this.adressCity});

  @override
  List<Object?> get props =>
      [adressID, adressName, adressDetails, adressPhone, adressCity];
}
