import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String categoryID;
  final String categoryName;
  final String categoryImage;

  const CategoryEntity({
    required this.categoryID,
    required this.categoryName,
    required this.categoryImage,
  });

  @override
  List<Object?> get props => [
        categoryID,
        categoryName,
        categoryImage,
      ];
}
