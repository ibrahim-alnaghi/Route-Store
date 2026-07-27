import 'package:equatable/equatable.dart';

import '../../../cart/domain/entities/cart_entity/cart_products_entity.dart';

enum OrderStatus { pending, processing, delivered }

class OrderShippingAddress extends Equatable {
  final String details;
  final String phone;
  final String city;

  const OrderShippingAddress(
      {required this.details, required this.phone, required this.city});

  @override
  List<Object?> get props => [details, phone, city];
}

class OrderEntity extends Equatable {
  final String orderId;
  final String cartId;
  final num totalOrderPrice;
  final String paymentMethodType;
  final bool isPaid;
  final bool isDelivered;
  final DateTime? createdAt;
  final List<CartProductsEntity> orderItems;
  final OrderShippingAddress? shippingAddress;
  final num? taxPrice;
  final num? shippingPrice;
  final String? orderNumber;

  const OrderEntity({
    required this.orderId,
    required this.cartId,
    required this.totalOrderPrice,
    required this.paymentMethodType,
    required this.isPaid,
    required this.isDelivered,
    this.createdAt,
    this.orderItems = const [],
    this.shippingAddress,
    this.taxPrice,
    this.shippingPrice,
    this.orderNumber,
  });

  /// A short, human-friendly order reference (this backend's sequential
  /// numeric `id`) — falls back to [orderId] (the Mongo `_id`) if the
  /// short number wasn't present on the response.
  String get displayNumber => orderNumber ?? orderId;

  OrderStatus get status => isDelivered
      ? OrderStatus.delivered
      : (isPaid ? OrderStatus.processing : OrderStatus.pending);

  @override
  List<Object?> get props => [
        orderId,
        cartId,
        totalOrderPrice,
        paymentMethodType,
        isPaid,
        isDelivered,
        createdAt,
        orderItems,
        shippingAddress,
        taxPrice,
        shippingPrice,
        orderNumber,
      ];
}
