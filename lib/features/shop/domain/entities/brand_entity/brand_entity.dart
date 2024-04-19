import 'package:equatable/equatable.dart';

class BrandEntity extends Equatable {
  final String brandID;
  final String brandName;
  final String brandImage;

  const BrandEntity({
    required this.brandID,
    required this.brandName,
    required this.brandImage,
  });

  @override
  List<Object?> get props => [
        brandID,
        brandName,
        brandImage,
      ];
}
