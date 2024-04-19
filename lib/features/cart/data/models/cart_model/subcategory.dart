import 'package:route_store/features/cart/domain/entities/cart_entity/cart_subcategory_entity.dart';

class Subcategory extends CartSubcategoryEntity {
  final String? sId;
  final String? name;
  final String? slug;
  final String? category;

  const Subcategory({this.sId, this.name, this.slug, this.category})
      : super(
            subCategoryId: sId ?? '',
            subCategoryName: name ?? '',
            subCategorySlug: slug ?? '',
            mainCategory: category ?? '');

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        sId: json['_id'],
        name: json['name'],
        slug: json['slug'],
        category: json['category'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['slug'] = slug;
    data['category'] = category;
    return data;
  }
}
