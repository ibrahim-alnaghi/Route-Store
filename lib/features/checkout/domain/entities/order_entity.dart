import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String orderId;
  final String cartId;
  final num totalOrderPrice;
  final String paymentMethodType;
  final bool isPaid;
  final bool isDelivered;

  const OrderEntity({
    required this.orderId,
    required this.cartId,
    required this.totalOrderPrice,
    required this.paymentMethodType,
    required this.isPaid,
    required this.isDelivered,
  });

  @override
  List<Object?> get props => [
        orderId,
        cartId,
        totalOrderPrice,
        paymentMethodType,
        isPaid,
        isDelivered,
      ];
}
