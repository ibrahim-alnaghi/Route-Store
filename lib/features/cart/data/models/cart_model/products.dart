import 'package:route_store/features/cart/data/models/cart_model/product.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_products_entity.dart';

class Products extends CartProductsEntity {
  final num? count;
  final String? sId;
  final Product? product;
  final num? price;

  Products({this.count, this.sId, this.product, this.price})
      : super(
            itemCount: count ?? 0,
            itemId: sId ?? '',
            productDetails: product ?? Product(),
            itemPrice: price ?? 0);

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        count: json['count'],
        sId: json['_id'],
        product:
            json['product'] != null ? Product.fromJson(json['product']) : null,
        price: json['price'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['_id'] = sId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['price'] = price;
    return data;
  }
}
