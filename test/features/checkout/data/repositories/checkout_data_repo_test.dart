import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/checkout/data/datasources/checkout_data_source.dart';
import 'package:route_store/features/checkout/data/models/order_model.dart';
import 'package:route_store/features/checkout/data/models/place_order_request_body.dart';
import 'package:route_store/features/checkout/data/repositories/checkout_data_repo.dart';

class MockCheckoutDataSource extends Mock implements CheckoutDataSource {}

class FakePlaceOrderRequestBody extends Fake implements PlaceOrderRequestBody {}

void main() {
  late CheckoutDataRepo sut;
  late MockCheckoutDataSource mockDataSource;

  setUpAll(() {
    registerFallbackValue(FakePlaceOrderRequestBody());
  });

  setUp(() {
    mockDataSource = MockCheckoutDataSource();
    sut = CheckoutDataRepo(mockDataSource);
  });

  DioException buildDioException(DioExceptionType type, {Response? response}) =>
      DioException(
        requestOptions: RequestOptions(path: ''),
        type: type,
        response: response,
      );

  final requestBody = PlaceOrderRequestBody(
    cartId: 'cart1',
    details: 'street 1',
    phone: '01000000000',
    city: 'Cairo',
  );

  const fakeOrder = OrderModel(
    id: 'order1',
    cartIdValue: 'cart1',
    totalOrderPriceValue: 250,
    paymentMethodTypeValue: 'cash',
    isPaidValue: false,
    isDeliveredValue: false,
  );

  group('CheckoutDataRepo.placeOrder', () {
    test('should return Right(OrderEntity) when the data source call succeeds',
        () async {
      // arrange
      when(() => mockDataSource.placeOrder(any()))
          .thenAnswer((_) async => fakeOrder);

      // act
      final result = await sut.placeOrder(requestBody);

      // assert
      expect(result, isA<Right>());
      result.fold(
        (l) => fail('expected Right'),
        (r) => expect(r, equals(fakeOrder)),
      );
    });

    test('should call the data source with the given request body', () async {
      // arrange
      when(() => mockDataSource.placeOrder(any()))
          .thenAnswer((_) async => fakeOrder);

      // act
      await sut.placeOrder(requestBody);

      // assert
      verify(() => mockDataSource.placeOrder(requestBody)).called(1);
    });

    test(
        'should return Left(ServerFailures) with generic message when data source throws Exception',
        () async {
      // arrange
      when(() => mockDataSource.placeOrder(any()))
          .thenThrow(Exception('unexpected'));

      // act
      final result = await sut.placeOrder(requestBody);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, contains('Exception: unexpected'));
        },
        (_) => fail('expected Left'),
      );
    });

    test(
        'should return Left(ServerFailures) with connection message when data source throws DioException(connectionError)',
        () async {
      // arrange
      when(() => mockDataSource.placeOrder(any()))
          .thenThrow(buildDioException(DioExceptionType.connectionError));

      // act
      final result = await sut.placeOrder(requestBody);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('No Internet Connection'));
        },
        (_) => fail('expected Left'),
      );
    });

    test(
        'should return Left(ServerFailures) with timeout message when data source throws DioException(connectionTimeout)',
        () async {
      // arrange
      when(() => mockDataSource.placeOrder(any()))
          .thenThrow(buildDioException(DioExceptionType.connectionTimeout));

      // act
      final result = await sut.placeOrder(requestBody);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('Connection timeout with api server'));
        },
        (_) => fail('expected Left'),
      );
    });

    test(
        'should return Left(ServerFailures) with cancel message when data source throws DioException(cancel)',
        () async {
      // arrange
      when(() => mockDataSource.placeOrder(any()))
          .thenThrow(buildDioException(DioExceptionType.cancel));

      // act
      final result = await sut.placeOrder(requestBody);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('Request to ApiServer was canceld'));
        },
        (_) => fail('expected Left'),
      );
    });

    test(
        'should return Left(ServerFailures) mapped from the response body when data source throws DioException(badResponse) with a 404',
        () async {
      // arrange
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 404,
      );
      when(() => mockDataSource.placeOrder(any())).thenThrow(
          buildDioException(DioExceptionType.badResponse, response: response));

      // act
      final result = await sut.placeOrder(requestBody);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('Your request was not found'));
        },
        (_) => fail('expected Left'),
      );
    });
  });
}
