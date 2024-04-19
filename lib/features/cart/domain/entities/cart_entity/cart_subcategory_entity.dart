import 'package:equatable/equatable.dart';

class CartSubcategoryEntity extends Equatable {
  final String subCategoryId;
  final String subCategoryName;
  final String subCategorySlug;
  final String mainCategory;

  const CartSubcategoryEntity(
      {required this.subCategoryId,
      required this.subCategoryName,
      required this.subCategorySlug,
      required this.mainCategory});

  @override
  List<Object?> get props =>
      [subCategoryId, subCategoryName, subCategorySlug, mainCategory];
}
