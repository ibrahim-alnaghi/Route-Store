import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/cart/data/datasources/cart_data_source.dart';
import 'package:route_store/features/cart/data/models/cart_model/cart_model.dart';
import 'package:route_store/features/cart/data/repositories/cart_data_repo.dart';

class MockCartDataSource extends Mock implements CartDataSource {}

void main() {
  late CartDataRepo sut;
  late MockCartDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockCartDataSource();
    sut = CartDataRepo(mockDataSource);
  });

  DioException buildDioException(DioExceptionType type, {Response? response}) =>
      DioException(
        requestOptions: RequestOptions(path: ''),
        type: type,
        response: response,
      );

  final fakeCart = CartModel(status: 'success', numOfCartItems: 1);

  group('CartDataRepo.getCart', () {
    test('should return Right(CartEntity) when the data source call succeeds',
        () async {
      when(() => mockDataSource.getCart()).thenAnswer((_) async => fakeCart);

      final result = await sut.getCart();

      expect(result, isA<Right>());
      result.fold(
        (l) => fail('expected Right'),
        (r) => expect(r, equals(fakeCart)),
      );
    });

    test(
        'should return Left(ServerFailures) with generic message when data source throws Exception',
        () async {
      when(() => mockDataSource.getCart()).thenThrow(Exception('unexpected'));

      final result = await sut.getCart();

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
      when(() => mockDataSource.getCart())
          .thenThrow(buildDioException(DioExceptionType.connectionError));

      final result = await sut.getCart();

      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('No Internet Connection'));
        },
        (_) => fail('expected Left'),
      );
    });
  });

  group('CartDataRepo.addProductToCart', () {
    test('should return Right(void) when the data source call succeeds',
        () async {
      when(() => mockDataSource.addProductToCart(any()))
          .thenAnswer((_) async {});

      final result = await sut.addProductToCart('product1');

      expect(result, isA<Right>());
      verify(() => mockDataSource.addProductToCart('product1')).called(1);
    });

    test(
        'should return Left(ServerFailures) with generic message when data source throws Exception',
        () async {
      when(() => mockDataSource.addProductToCart(any()))
          .thenThrow(Exception('unexpected'));

      final result = await sut.addProductToCart('product1');

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
        'should return Left(ServerFailures) with timeout message when data source throws DioException(connectionTimeout)',
        () async {
      when(() => mockDataSource.addProductToCart(any()))
          .thenThrow(buildDioException(DioExceptionType.connectionTimeout));

      final result = await sut.addProductToCart('product1');

      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('Connection timeout with api server'));
        },
        (_) => fail('expected Left'),
      );
    });
  });

  group('CartDataRepo.applyCoupon', () {
    test('should return Right(CartEntity) when the data source call succeeds',
        () async {
      when(() => mockDataSource.applyCoupon(any()))
          .thenAnswer((_) async => fakeCart);

      final result = await sut.applyCoupon('SAVE20');

      expect(result, isA<Right>());
      result.fold(
        (l) => fail('expected Right'),
        (r) => expect(r, equals(fakeCart)),
      );
      verify(() => mockDataSource.applyCoupon('SAVE20')).called(1);
    });

    test(
        'should return Left(ServerFailures) with generic message when data source throws Exception',
        () async {
      when(() => mockDataSource.applyCoupon(any()))
          .thenThrow(Exception('invalid coupon'));

      final result = await sut.applyCoupon('INVALID');

      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, contains('Exception: invalid coupon'));
        },
        (_) => fail('expected Left'),
      );
    });

    test(
        'should return Left(ServerFailures) mapped from the response body when data source throws DioException(badResponse) with a 404',
        () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 404,
      );
      when(() => mockDataSource.applyCoupon(any())).thenThrow(
          buildDioException(DioExceptionType.badResponse, response: response));

      final result = await sut.applyCoupon('INVALID');

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
