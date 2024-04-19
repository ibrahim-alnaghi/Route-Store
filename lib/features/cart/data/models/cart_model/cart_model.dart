import 'package:route_store/features/cart/data/models/cart_model/data.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_entity.dart';

class CartModel extends CartEntity {
  final String? status;
  final num? numOfCartItems;
  final Data? data;

  CartModel({this.status, this.numOfCartItems, this.data})
      : super(cartItemsCount: numOfCartItems ?? 0, cartItems: data ?? Data());

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        status: json['status'],
        numOfCartItems: json['numOfCartItems'],
        data: json['data'] != null ? Data.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['numOfCartItems'] = numOfCartItems;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
