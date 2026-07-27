import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/api/api_service.dart';
import 'package:route_store/core/constants/api_constants.dart';
import 'package:route_store/core/di/injection_container.dart';
import 'package:route_store/features/authentication/domain/entities/user_entity.dart';
import 'package:route_store/features/checkout/data/models/order_model.dart';
import 'package:route_store/features/orders/data/datasources/remote/orders_remote_data.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late OrdersRemoteData sut;
  late MockApiService mockApiService;

  String encodeSegment(Object value) {
    final jsonString = value is String ? value : jsonEncode(value);
    return base64Url.encode(utf8.encode(jsonString));
  }

  String buildToken(Map<String, dynamic> payload) {
    final header = encodeSegment({'alg': 'HS256', 'typ': 'JWT'});
    final body = encodeSegment(payload);
    const signature = 'dummy-signature';
    return '$header.$body.$signature';
  }

  const expectedUserId = 'user-42';
  final validToken = buildToken({'id': expectedUserId, 'name': 'Test User'});

  final fakeUser = UserEntity(
    userToken: validToken,
    userName: 'Test User',
    userEmail: 'test@example.com',
  );

  void registerFakeUser(UserEntity user) {
    if (getIt.isRegistered<UserEntity>()) {
      getIt.unregister<UserEntity>();
    }
    getIt.registerSingleton<UserEntity>(user);
  }

  setUp(() {
    mockApiService = MockApiService();
    sut = OrdersRemoteData(mockApiService);
    registerFakeUser(fakeUser);
  });

  tearDown(() {
    if (getIt.isRegistered<UserEntity>()) {
      getIt.unregister<UserEntity>();
    }
  });

  void stubApiServiceGetList(List<dynamic> response) {
    when(() => mockApiService.getList(
          endPoint: any(named: 'endPoint'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) async => response);
  }

  final ordersJson = [
    {
      '_id': 'order1',
      'id': 6184,
      'totalOrderPrice': 250,
      'taxPrice': 10,
      'shippingPrice': 15,
      'paymentMethodType': 'cash',
      'isPaid': false,
      'isDelivered': false,
      'createdAt': '2024-01-01T00:00:00.000Z',
      'cartItems': [
        {'count': 1, '_id': 'item1', 'price': 100},
      ],
      'shippingAddress': {
        'details': 'street 1',
        'phone': '01000000000',
        'city': 'Cairo',
      },
    },
    {
      '_id': 'order2',
      'totalOrderPrice': 500,
      'paymentMethodType': 'card',
      'isPaid': true,
      'isDelivered': true,
      'createdAt': '2024-02-02T00:00:00.000Z',
      'cartItems': <dynamic>[],
      'shippingAddress': {
        'details': 'street 2',
        'phone': '01100000000',
        'city': 'Giza',
      },
    },
  ];

  test(
      'calls ApiService.getList with the my-orders endpoint suffixed with the id decoded from the token and the token header',
      () async {
    // arrange
    stubApiServiceGetList(ordersJson);

    // act
    await sut.getMyOrders();

    // assert
    verify(() => mockApiService.getList(
          endPoint: '${EndPoints.myOrders}/$expectedUserId',
          headers: {"token": validToken},
        )).called(1);
  });

  test('parses the response list into OrderModel instances', () async {
    // arrange
    stubApiServiceGetList(ordersJson);

    // act
    final result = await sut.getMyOrders();

    // assert
    expect(result, isA<List<OrderModel>>());
    expect(result, hasLength(2));

    expect(result[0].orderId, equals('order1'));
    expect(result[0].orderNumber, equals('6184'));
    expect(result[0].displayNumber, equals('6184'));
    expect(result[0].totalOrderPrice, equals(250));
    expect(result[0].taxPrice, equals(10));
    expect(result[0].shippingPrice, equals(15));
    expect(result[0].paymentMethodType, equals('cash'));
    expect(result[0].isPaid, isFalse);
    expect(result[0].isDelivered, isFalse);
    expect(result[0].createdAt,
        equals(DateTime.parse('2024-01-01T00:00:00.000Z')));
    expect(result[0].orderItems, hasLength(1));
    expect(result[0].shippingAddress?.details, equals('street 1'));
    expect(result[0].shippingAddress?.phone, equals('01000000000'));
    expect(result[0].shippingAddress?.city, equals('Cairo'));

    expect(result[1].orderId, equals('order2'));
    expect(result[1].isPaid, isTrue);
    expect(result[1].isDelivered, isTrue);
    expect(result[1].orderItems, isEmpty);
    expect(result[1].orderNumber, isNull);
    expect(result[1].displayNumber, equals('order2'));
    expect(result[1].taxPrice, isNull);
    expect(result[1].shippingPrice, isNull);
  });

  test(
      'throws before calling ApiService.getList when the user id cannot be resolved from the token',
      () async {
    // arrange
    const malformedUser = UserEntity(
      userToken: 'not-a-jwt-token',
      userName: 'Test User',
      userEmail: 'test@example.com',
    );
    registerFakeUser(malformedUser);

    // act & assert
    await expectLater(() => sut.getMyOrders(), throwsException);
    verifyNever(() => mockApiService.getList(
          endPoint: any(named: 'endPoint'),
          headers: any(named: 'headers'),
        ));
  });
}
