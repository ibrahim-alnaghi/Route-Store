import 'package:route_store/features/cart/domain/entities/cart_entity/cart_brand_or_category_entity.dart';

class Category extends CartBrandOrCategoryEntity {
  final String? sId;
  final String? name;
  final String? slug;
  final String? image;

  const Category({this.sId, this.name, this.slug, this.image})
      : super(
            categoryId: sId ?? '',
            categoryName: name ?? '',
            categorySlug: slug ?? '',
            categoryImage: image ?? '');

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        sId: json['_id'],
        name: json['name'],
        slug: json['slug'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['slug'] = slug;
    data['image'] = image;
    return data;
  }
}
