import 'package:flutter_test/flutter_test.dart';
import 'package:route_store/features/checkout/domain/entities/order_entity.dart';

void main() {
  OrderEntity buildOrder({required bool isPaid, required bool isDelivered}) =>
      OrderEntity(
        orderId: 'order1',
        cartId: 'cart1',
        totalOrderPrice: 250,
        paymentMethodType: 'cash',
        isPaid: isPaid,
        isDelivered: isDelivered,
      );

  group('OrderEntity.status', () {
    test('should be delivered when isDelivered is true regardless of isPaid',
        () {
      final order = buildOrder(isPaid: false, isDelivered: true);
      expect(order.status, equals(OrderStatus.delivered));
    });

    test('should be delivered when both isPaid and isDelivered are true', () {
      final order = buildOrder(isPaid: true, isDelivered: true);
      expect(order.status, equals(OrderStatus.delivered));
    });

    test('should be processing when isPaid is true and isDelivered is false',
        () {
      final order = buildOrder(isPaid: true, isDelivered: false);
      expect(order.status, equals(OrderStatus.processing));
    });

    test(
        'should be pending when neither isPaid nor isDelivered are true',
        () {
      final order = buildOrder(isPaid: false, isDelivered: false);
      expect(order.status, equals(OrderStatus.pending));
    });
  });

  group('OrderEntity defaults', () {
    test('orderItems defaults to an empty list when not provided', () {
      final order = buildOrder(isPaid: false, isDelivered: false);
      expect(order.orderItems, isEmpty);
    });

    test('createdAt and shippingAddress default to null when not provided',
        () {
      final order = buildOrder(isPaid: false, isDelivered: false);
      expect(order.createdAt, isNull);
      expect(order.shippingAddress, isNull);
    });
  });

  group('OrderEntity.displayNumber', () {
    test('returns orderNumber when it is non-null', () {
      const order = OrderEntity(
        orderId: '6a67b9e1fc33d800123d52ba',
        cartId: 'cart1',
        totalOrderPrice: 250,
        paymentMethodType: 'cash',
        isPaid: false,
        isDelivered: false,
        orderNumber: '6184',
      );
      expect(order.displayNumber, equals('6184'));
    });

    test('falls back to orderId when orderNumber is null', () {
      final order = buildOrder(isPaid: false, isDelivered: false);
      expect(order.orderNumber, isNull);
      expect(order.displayNumber, equals(order.orderId));
    });
  });

  group('OrderEntity equality', () {
    test('two instances differing only in orderNumber are not equal', () {
      const a = OrderEntity(
        orderId: 'order1',
        cartId: 'cart1',
        totalOrderPrice: 250,
        paymentMethodType: 'cash',
        isPaid: false,
        isDelivered: false,
        orderNumber: '6184',
      );
      const b = OrderEntity(
        orderId: 'order1',
        cartId: 'cart1',
        totalOrderPrice: 250,
        paymentMethodType: 'cash',
        isPaid: false,
        isDelivered: false,
        orderNumber: '9999',
      );
      expect(a, isNot(equals(b)));
    });

    test('two instances differing only in taxPrice are not equal', () {
      const a = OrderEntity(
        orderId: 'order1',
        cartId: 'cart1',
        totalOrderPrice: 250,
        paymentMethodType: 'cash',
        isPaid: false,
        isDelivered: false,
        taxPrice: 10,
      );
      const b = OrderEntity(
        orderId: 'order1',
        cartId: 'cart1',
        totalOrderPrice: 250,
        paymentMethodType: 'cash',
        isPaid: false,
        isDelivered: false,
        taxPrice: 20,
      );
      expect(a, isNot(equals(b)));
    });

    test('two instances differing only in shippingPrice are not equal', () {
      const a = OrderEntity(
        orderId: 'order1',
        cartId: 'cart1',
        totalOrderPrice: 250,
        paymentMethodType: 'cash',
        isPaid: false,
        isDelivered: false,
        shippingPrice: 15,
      );
      const b = OrderEntity(
        orderId: 'order1',
        cartId: 'cart1',
        totalOrderPrice: 250,
        paymentMethodType: 'cash',
        isPaid: false,
        isDelivered: false,
        shippingPrice: 30,
      );
      expect(a, isNot(equals(b)));
    });

    test(
        'two instances with identical fields including orderNumber, taxPrice and shippingPrice are equal',
        () {
      const a = OrderEntity(
        orderId: 'order1',
        cartId: 'cart1',
        totalOrderPrice: 250,
        paymentMethodType: 'cash',
        isPaid: false,
        isDelivered: false,
        orderNumber: '6184',
        taxPrice: 10,
        shippingPrice: 15,
      );
      const b = OrderEntity(
        orderId: 'order1',
        cartId: 'cart1',
        totalOrderPrice: 250,
        paymentMethodType: 'cash',
        isPaid: false,
        isDelivered: false,
        orderNumber: '6184',
        taxPrice: 10,
        shippingPrice: 15,
      );
      expect(a, equals(b));
    });
  });

  group('OrderShippingAddress equality', () {
    test('two instances with the same fields are equal', () {
      const a = OrderShippingAddress(
          details: 'street 1', phone: '01000000000', city: 'Cairo');
      const b = OrderShippingAddress(
          details: 'street 1', phone: '01000000000', city: 'Cairo');
      expect(a, equals(b));
    });

    test('two instances with different fields are not equal', () {
      const a = OrderShippingAddress(
          details: 'street 1', phone: '01000000000', city: 'Cairo');
      const b = OrderShippingAddress(
          details: 'street 2', phone: '01000000000', city: 'Cairo');
      expect(a, isNot(equals(b)));
    });
  });
}
