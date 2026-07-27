import '../../../cart/data/models/cart_model/products.dart';
import '../../domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  final String? id;
  final String? cartIdValue;
  final num? totalOrderPriceValue;
  final String? paymentMethodTypeValue;
  final bool? isPaidValue;
  final bool? isDeliveredValue;
  final DateTime? createdAtValue;
  final List<Products>? orderItemsValue;
  final OrderShippingAddress? shippingAddressValue;
  final num? taxPriceValue;
  final num? shippingPriceValue;
  final String? orderNumberValue;

  OrderModel({
    this.id,
    this.cartIdValue,
    this.totalOrderPriceValue,
    this.paymentMethodTypeValue,
    this.isPaidValue,
    this.isDeliveredValue,
    this.createdAtValue,
    this.orderItemsValue,
    this.shippingAddressValue,
    this.taxPriceValue,
    this.shippingPriceValue,
    this.orderNumberValue,
  }) : super(
          orderId: id ?? '',
          cartId: cartIdValue ?? '',
          totalOrderPrice: totalOrderPriceValue ?? 0,
          paymentMethodType: paymentMethodTypeValue ?? 'cash',
          isPaid: isPaidValue ?? false,
          isDelivered: isDeliveredValue ?? false,
          createdAt: createdAtValue,
          orderItems: orderItemsValue ?? const [],
          shippingAddress: shippingAddressValue,
          taxPrice: taxPriceValue,
          shippingPrice: shippingPriceValue,
          orderNumber: orderNumberValue,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final data =
        json['data'] is Map<String, dynamic> ? json['data'] as Map<String, dynamic> : json;
    return OrderModel(
      id: data['_id']?.toString(),
      cartIdValue: data['cartId']?.toString(),
      totalOrderPriceValue: data['totalOrderPrice'] as num?,
      paymentMethodTypeValue: data['paymentMethodType'] as String?,
      isPaidValue: data['isPaid'] as bool?,
      isDeliveredValue: data['isDelivered'] as bool?,
      createdAtValue: data['createdAt'] != null
          ? DateTime.tryParse(data['createdAt'].toString())
          : null,
      orderItemsValue: (data['cartItems'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
      shippingAddressValue: data['shippingAddress'] is Map<String, dynamic>
          ? OrderShippingAddress(
              details: (data['shippingAddress']['details'] ?? '').toString(),
              phone: (data['shippingAddress']['phone'] ?? '').toString(),
              city: (data['shippingAddress']['city'] ?? '').toString(),
            )
          : null,
      taxPriceValue: data['taxPrice'] as num?,
      shippingPriceValue: data['shippingPrice'] as num?,
      orderNumberValue: data['id']?.toString(),
    );
  }
}
