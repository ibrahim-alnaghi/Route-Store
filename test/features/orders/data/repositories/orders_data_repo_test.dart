import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/checkout/data/models/order_model.dart';
import 'package:route_store/features/orders/data/datasources/orders_data_source.dart';
import 'package:route_store/features/orders/data/repositories/orders_data_repo.dart';

class MockOrdersDataSource extends Mock implements OrdersDataSource {}

void main() {
  late OrdersDataRepo sut;
  late MockOrdersDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockOrdersDataSource();
    sut = OrdersDataRepo(mockDataSource);
  });

  DioException buildDioException(DioExceptionType type, {Response? response}) =>
      DioException(
        requestOptions: RequestOptions(path: ''),
        type: type,
        response: response,
      );

  final fakeOrders = [
    const OrderModel(
      id: 'order1',
      totalOrderPriceValue: 250,
      paymentMethodTypeValue: 'cash',
      isPaidValue: false,
      isDeliveredValue: false,
    ),
  ];

  group('OrdersDataRepo.getMyOrders', () {
    test(
        'should return Right(List<OrderEntity>) when the data source call succeeds',
        () async {
      // arrange
      when(() => mockDataSource.getMyOrders())
          .thenAnswer((_) async => fakeOrders);

      // act
      final result = await sut.getMyOrders();

      // assert
      expect(result, isA<Right>());
      result.fold(
        (l) => fail('expected Right'),
        (r) => expect(r, equals(fakeOrders)),
      );
    });

    test('should call the data source with no arguments', () async {
      // arrange
      when(() => mockDataSource.getMyOrders())
          .thenAnswer((_) async => fakeOrders);

      // act
      await sut.getMyOrders();

      // assert
      verify(() => mockDataSource.getMyOrders()).called(1);
    });

    test(
        'should return Left(ServerFailures) with generic message when data source throws Exception',
        () async {
      // arrange
      when(() => mockDataSource.getMyOrders())
          .thenThrow(Exception('unexpected'));

      // act
      final result = await sut.getMyOrders();

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
      when(() => mockDataSource.getMyOrders())
          .thenThrow(buildDioException(DioExceptionType.connectionError));

      // act
      final result = await sut.getMyOrders();

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
      when(() => mockDataSource.getMyOrders())
          .thenThrow(buildDioException(DioExceptionType.connectionTimeout));

      // act
      final result = await sut.getMyOrders();

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
      when(() => mockDataSource.getMyOrders())
          .thenThrow(buildDioException(DioExceptionType.cancel));

      // act
      final result = await sut.getMyOrders();

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
      when(() => mockDataSource.getMyOrders()).thenThrow(
          buildDioException(DioExceptionType.badResponse, response: response));

      // act
      final result = await sut.getMyOrders();

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
