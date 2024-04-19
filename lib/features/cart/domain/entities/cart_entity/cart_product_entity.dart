import 'package:equatable/equatable.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_brand_or_category_entity.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_subcategory_entity.dart';

class CartProductEntity extends Equatable {
  final String productId;
  final String productName;
  final num productQuantity;
  final num averageRating;
  final String coverImage;
  final CartBrandOrCategoryEntity productCategory;
  final List<CartSubcategoryEntity> productSubcategory;
  final CartBrandOrCategoryEntity productBrand;

  const CartProductEntity({
    required this.productSubcategory,
    required this.productId,
    required this.productName,
    required this.productQuantity,
    required this.coverImage,
    required this.productCategory,
    required this.productBrand,
    required this.averageRating,
  });

  @override
  List<Object?> get props => [
        productSubcategory,
        productId,
        productName,
        productQuantity,
        coverImage,
        productCategory,
        productBrand,
        averageRating,
      ];
}
