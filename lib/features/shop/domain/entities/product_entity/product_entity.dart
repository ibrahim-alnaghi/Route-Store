import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String productID;
  final String productName;
  final String productDescription;
  final List<String> productImages;
  final num quantityRatings;
  final num averageRatings;
  final num productQuantity;
  final num productPrice;
  final num productPriceAfterDiscount;
  final num discountPercentage;
  final String productImageCover;
  final String productBrand;
  final String brandImage;

  const ProductEntity(
      {required this.productID,
      required this.productName,
      required this.productDescription,
      required this.productImages,
      required this.quantityRatings,
      required this.averageRatings,
      required this.productQuantity,
      required this.productPrice,
      required this.productPriceAfterDiscount,
      required this.discountPercentage,
      required this.productImageCover,
      required this.productBrand,
      required this.brandImage});

  @override
  List<Object?> get props => [
        productID,
        productName,
        productDescription,
        productImages,
        quantityRatings,
        averageRatings,
        productQuantity,
        productPrice,
        productPriceAfterDiscount,
        discountPercentage,
        productImageCover,
        productBrand,
        brandImage
      ];
}
