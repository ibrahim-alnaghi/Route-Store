import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/api/api_service.dart';
import 'package:route_store/core/constants/api_constants.dart';
import 'package:route_store/core/di/injection_container.dart';
import 'package:route_store/features/authentication/domain/entities/user_entity.dart';
import 'package:route_store/features/checkout/data/datasources/remote/checkout_remote_data.dart';
import 'package:route_store/features/checkout/data/models/order_model.dart';
import 'package:route_store/features/checkout/data/models/place_order_request_body.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late CheckoutRemoteData sut;
  late MockApiService mockApiService;

  const fakeUser = UserEntity(
    userToken: 'test-token',
    userName: 'Test User',
    userEmail: 'test@example.com',
  );

  setUp(() {
    mockApiService = MockApiService();
    sut = CheckoutRemoteData(mockApiService);

    if (getIt.isRegistered<UserEntity>()) {
      getIt.unregister<UserEntity>();
    }
    getIt.registerSingleton<UserEntity>(fakeUser);
  });

  tearDown(() {
    if (getIt.isRegistered<UserEntity>()) {
      getIt.unregister<UserEntity>();
    }
  });

  final requestBody = PlaceOrderRequestBody(
    cartId: 'cart1',
    details: 'street 1',
    phone: '01000000000',
    city: 'Cairo',
  );

  void stubApiServicePost(Map<String, dynamic> response) {
    when(() => mockApiService.post(
          endPoint: any(named: 'endPoint'),
          data: any(named: 'data'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) async => response);
  }

  final orderJson = {
    '_id': 'order1',
    'cartId': 'cart1',
    'totalOrderPrice': 250,
    'paymentMethodType': 'cash',
    'isPaid': false,
    'isDelivered': false,
  };

  test(
      'calls ApiService.post with the orders endpoint suffixed with the cart id, the serialized body and the token header',
      () async {
    // arrange
    stubApiServicePost(orderJson);

    // act
    await sut.placeOrder(requestBody);

    // assert
    verify(() => mockApiService.post(
          endPoint: '${EndPoints.orders}/${requestBody.cartId}',
          data: requestBody.toJson(),
          headers: {"token": fakeUser.userToken},
        )).called(1);
  });

  test('parses a flat response (no "data" envelope) into an OrderModel',
      () async {
    // arrange
    stubApiServicePost(orderJson);

    // act
    final result = await sut.placeOrder(requestBody);

    // assert
    expect(result, isA<OrderModel>());
    expect(result.orderId, equals('order1'));
    expect(result.cartId, equals('cart1'));
    expect(result.totalOrderPrice, equals(250));
    expect(result.paymentMethodType, equals('cash'));
    expect(result.isPaid, isFalse);
    expect(result.isDelivered, isFalse);
  });

  test('parses a response wrapped in a "data" envelope into an OrderModel',
      () async {
    // arrange
    stubApiServicePost({'data': orderJson});

    // act
    final result = await sut.placeOrder(requestBody);

    // assert
    expect(result, isA<OrderModel>());
    expect(result.orderId, equals('order1'));
    expect(result.cartId, equals('cart1'));
    expect(result.totalOrderPrice, equals(250));
    expect(result.paymentMethodType, equals('cash'));
    expect(result.isPaid, isFalse);
    expect(result.isDelivered, isFalse);
  });

  test('propagates the exception thrown by ApiService without catching it',
      () async {
    // arrange
    when(() => mockApiService.post(
          endPoint: any(named: 'endPoint'),
          data: any(named: 'data'),
          headers: any(named: 'headers'),
        )).thenThrow(Exception('network down'));

    // act & assert
    expect(() => sut.placeOrder(requestBody), throwsException);
  });
}
