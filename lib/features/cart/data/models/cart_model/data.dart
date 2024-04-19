import 'package:route_store/features/cart/data/models/cart_model/products.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_items.dart';

class Data extends CartItemsEntity {
  final String? sId;
  final String? cartOwner;
  final List<Products>? products;
  final String? createdAt;
  final String? updatedAt;
  final int? iV;
  final num? totalCartPrice;

  Data(
      {this.sId,
      this.cartOwner,
      this.products,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.totalCartPrice})
      : super(
            cartId: sId ?? '',
            cartProducts: products ?? [],
            totalPrice: totalCartPrice ?? 0);

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sId: json['_id'],
        cartOwner: json['cartOwner'],
        products: (json['products'] as List?)
            ?.map((item) => Products.fromJson(item))
            .toList(),
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        iV: json['__v'],
        totalCartPrice: json['totalCartPrice'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['cartOwner'] = cartOwner;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['totalCartPrice'] = totalCartPrice;
    return data;
  }
}
