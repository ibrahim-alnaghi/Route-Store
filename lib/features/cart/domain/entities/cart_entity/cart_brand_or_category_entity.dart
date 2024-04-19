import 'package:equatable/equatable.dart';

class CartBrandOrCategoryEntity extends Equatable {
  final String categoryId;
  final String categoryName;
  final String categorySlug;
  final String categoryImage;

  const CartBrandOrCategoryEntity(
      {required this.categoryId,
      required this.categoryName,
      required this.categorySlug,
      required this.categoryImage});

  @override
  List<Object?> get props =>
      [categoryId, categoryName, categorySlug, categoryImage];
}
