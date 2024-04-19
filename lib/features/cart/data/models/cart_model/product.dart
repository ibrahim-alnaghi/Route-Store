import 'package:route_store/features/cart/data/models/cart_model/category.dart';
import 'package:route_store/features/cart/data/models/cart_model/subcategory.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_product_entity.dart';

class Product extends CartProductEntity {
  final List<Subcategory>? subcategory;
  final String? sId;
  final String? title;
  final num? quantity;
  final String? imageCover;
  final Category? category;
  final Category? brand;
  final num? ratingsAverage;
  final String? id;

  Product(
      {this.subcategory,
      this.sId,
      this.title,
      this.quantity,
      this.imageCover,
      this.category,
      this.brand,
      this.ratingsAverage,
      this.id})
      : super(
            productId: sId ?? '',
            productName: title ?? '',
            productQuantity: quantity ?? 0,
            coverImage: imageCover ?? '',
            productCategory: category ?? const Category(),
            productSubcategory: subcategory ?? [],
            productBrand: brand ?? const Category(),
            averageRating: ratingsAverage ?? 0);

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        subcategory: (json['subcategory'] as List?)
            ?.map((item) => Subcategory.fromJson(item))
            .toList(),
        sId: json['_id'],
        title: json['title'],
        quantity: json['quantity'],
        imageCover: json['imageCover'],
        category: json['category'] != null
            ? Category.fromJson(json['category'])
            : null,
        brand: json['brand'] != null ? Category.fromJson(json['brand']) : null,
        ratingsAverage: json['ratingsAverage'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subcategory != null) {
      data['subcategory'] = subcategory!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['title'] = title;
    data['quantity'] = quantity;
    data['imageCover'] = imageCover;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    data['ratingsAverage'] = ratingsAverage;
    data['id'] = id;
    return data;
  }
}
