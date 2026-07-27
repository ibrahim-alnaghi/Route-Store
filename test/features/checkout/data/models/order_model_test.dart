import 'package:flutter_test/flutter_test.dart';
import 'package:route_store/features/checkout/data/models/order_model.dart';

void main() {
  final flatJson = {
    '_id': 'order1',
    'id': 6184,
    'cartId': 'cart1',
    'totalOrderPrice': 250,
    'taxPrice': 10,
    'shippingPrice': 15,
    'paymentMethodType': 'cash',
    'isPaid': false,
    'isDelivered': false,
    'createdAt': '2024-01-01T00:00:00.000Z',
    'cartItems': [
      {'count': 2, '_id': 'item1', 'price': 50},
    ],
    'shippingAddress': {
      'details': 'street 1',
      'phone': '01000000000',
      'city': 'Cairo',
    },
  };

  group('OrderModel.fromJson', () {
    test('parses a flat response (no "data" envelope) including the new fields',
        () {
      final model = OrderModel.fromJson(flatJson);

      expect(model.orderId, equals('order1'));
      expect(model.orderNumber, equals('6184'));
      expect(model.displayNumber, equals('6184'));
      expect(model.taxPrice, equals(10));
      expect(model.shippingPrice, equals(15));
      expect(model.createdAt, equals(DateTime.parse('2024-01-01T00:00:00.000Z')));
      expect(model.orderItems, hasLength(1));
      expect(model.shippingAddress?.details, equals('street 1'));
      expect(model.shippingAddress?.phone, equals('01000000000'));
      expect(model.shippingAddress?.city, equals('Cairo'));
    });

    test('parses a response wrapped in a "data" envelope', () {
      final model = OrderModel.fromJson({'data': flatJson});

      expect(model.orderId, equals('order1'));
      expect(model.orderNumber, equals('6184'));
      expect(model.taxPrice, equals(10));
      expect(model.shippingPrice, equals(15));
      expect(model.createdAt, equals(DateTime.parse('2024-01-01T00:00:00.000Z')));
      expect(model.orderItems, hasLength(1));
      expect(model.shippingAddress?.city, equals('Cairo'));
    });

    test(
        'parses the numeric "id" field (JSON number, e.g. 6184) into orderNumber as a string',
        () {
      final model = OrderModel.fromJson(flatJson);

      expect(model.orderNumberValue, equals('6184'));
      expect(model.orderNumber, isA<String>());
      expect(model.orderNumber, equals('6184'));
    });

    test('parses a string "id" field into orderNumber unchanged', () {
      final json = Map<String, dynamic>.from(flatJson)..['id'] = '6184';
      final model = OrderModel.fromJson(json);

      expect(model.orderNumber, equals('6184'));
    });

    test('defaults orderNumber to null when "id" is absent', () {
      final json = Map<String, dynamic>.from(flatJson)..remove('id');
      final model = OrderModel.fromJson(json);

      expect(model.orderNumber, isNull);
      expect(model.displayNumber, equals(model.orderId));
    });

    test('defaults taxPrice and shippingPrice to null (not 0) when absent',
        () {
      final json = Map<String, dynamic>.from(flatJson)
        ..remove('taxPrice')
        ..remove('shippingPrice');
      final model = OrderModel.fromJson(json);

      expect(model.taxPrice, isNull);
      expect(model.shippingPrice, isNull);
    });

    test('defaults createdAt to null when the key is absent', () {
      final json = Map<String, dynamic>.from(flatJson)..remove('createdAt');
      final model = OrderModel.fromJson(json);

      expect(model.createdAt, isNull);
    });

    test('defaults orderItems to an empty list when cartItems is absent', () {
      final json = Map<String, dynamic>.from(flatJson)..remove('cartItems');
      final model = OrderModel.fromJson(json);

      expect(model.orderItems, isEmpty);
    });

    test('defaults shippingAddress to null when the key is absent', () {
      final json = Map<String, dynamic>.from(flatJson)
        ..remove('shippingAddress');
      final model = OrderModel.fromJson(json);

      expect(model.shippingAddress, isNull);
    });

    test('status is derived correctly from isPaid/isDelivered after parsing',
        () {
      final deliveredJson = Map<String, dynamic>.from(flatJson)
        ..['isPaid'] = true
        ..['isDelivered'] = true;

      final model = OrderModel.fromJson(deliveredJson);

      expect(model.status.name, equals('delivered'));
    });
  });
}
