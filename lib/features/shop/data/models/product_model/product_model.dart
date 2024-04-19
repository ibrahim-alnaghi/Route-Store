import '../../../../../core/helpers/pricing_calculator.dart';
import '../../../domain/entities/product_entity/product_entity.dart';
import 'brand.dart';
import 'category.dart';
import 'subcategory.dart';

class ProductModel extends ProductEntity {
  final num? sold;
  final List<String>? images;
  final List<Subcategory>? subcategory;
  final num? ratingsQuantity;
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final num? quantity;
  final num? price;
  final num? priceAfterDiscount;
  final String? imageCover;
  final Category? category;
  final Brand? brand;
  final num? ratingsAverage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    this.sold,
    this.images,
    this.subcategory,
    this.ratingsQuantity,
    this.id,
    this.title,
    this.slug,
    this.description,
    this.quantity,
    this.price,
    this.priceAfterDiscount,
    this.imageCover,
    this.category,
    this.brand,
    this.ratingsAverage,
    this.createdAt,
    this.updatedAt,
  }) : super(
            productID: id ?? '',
            productName: title ?? '',
            productDescription: description ?? '',
            productImages: images ?? [],
            quantityRatings: ratingsQuantity ?? 0,
            averageRatings: ratingsAverage ?? 0,
            productQuantity: quantity ?? 0,
            productPrice: price ?? 0,
            productPriceAfterDiscount: priceAfterDiscount ?? 0,
            discountPercentage: PricingCalculator.calculateDiscountPercentage(
                price ?? 0, priceAfterDiscount ?? 0),
            productImageCover: imageCover ?? '',
            productBrand: brand?.name ?? '',
            brandImage: brand?.image ?? '');

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        sold: json['sold'] as num?,
        images: (json['images'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        subcategory: (json['subcategory'] as List<dynamic>?)
            ?.map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
            .toList(),
        ratingsQuantity: json['ratingsQuantity'] as num?,
        id: json['_id'] as String?,
        title: json['title'] as String?,
        slug: json['slug'] as String?,
        description: json['description'] as String?,
        quantity: json['quantity'] as num?,
        price: json['price'] as num?,
        priceAfterDiscount: json['priceAfterDiscount'] as num?,
        imageCover: json['imageCover'] as String?,
        category: json['category'] == null
            ? null
            : Category.fromJson(json['category'] as Map<String, dynamic>),
        brand: json['brand'] == null
            ? null
            : Brand.fromJson(json['brand'] as Map<String, dynamic>),
        ratingsAverage: (json['ratingsAverage'] as num?),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'sold': sold,
        'images': images,
        'subcategory': subcategory?.map((e) => e.toJson()).toList(),
        'ratingsQuantity': ratingsQuantity,
        '_id': id,
        'title': title,
        'slug': slug,
        'description': description,
        'quantity': quantity,
        'price': price,
        'priceAfterDiscount': priceAfterDiscount,
        'imageCover': imageCover,
        'category': category?.toJson(),
        'brand': brand?.toJson(),
        'ratingsAverage': ratingsAverage,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
