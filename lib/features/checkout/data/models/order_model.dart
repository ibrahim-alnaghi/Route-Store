import '../../domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  final String? id;
  final String? cartIdValue;
  final num? totalOrderPriceValue;
  final String? paymentMethodTypeValue;
  final bool? isPaidValue;
  final bool? isDeliveredValue;

  OrderModel({
    this.id,
    this.cartIdValue,
    this.totalOrderPriceValue,
    this.paymentMethodTypeValue,
    this.isPaidValue,
    this.isDeliveredValue,
  }) : super(
          orderId: id ?? '',
          cartId: cartIdValue ?? '',
          totalOrderPrice: totalOrderPriceValue ?? 0,
          paymentMethodType: paymentMethodTypeValue ?? 'cash',
          isPaid: isPaidValue ?? false,
          isDelivered: isDeliveredValue ?? false,
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
    );
  }
}
