import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/search/data/datasources/search_data_source.dart';
import 'package:route_store/features/search/data/repositories/search_data_repo.dart';
import 'package:route_store/features/shop/data/models/product_model/product_model.dart';

class MockSearchDataSource extends Mock implements SearchDataSource {}

void main() {
  late SearchDataRepo sut;
  late MockSearchDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockSearchDataSource();
    sut = SearchDataRepo(mockDataSource);
  });

  DioException buildDioException(DioExceptionType type, {Response? response}) =>
      DioException(
        requestOptions: RequestOptions(path: ''),
        type: type,
        response: response,
      );

  final fakeProduct = ProductModel(
      id: '1', title: 'Test Product', price: 100, priceAfterDiscount: 100);

  group('SearchDataRepo.searchProducts', () {
    test('should return Right(List<ProductEntity>) when the data source call succeeds',
        () async {
      // arrange
      when(() =>
              mockDataSource.searchProducts(keyword: any(named: 'keyword')))
          .thenAnswer((_) async => [fakeProduct]);

      // act
      final result = await sut.searchProducts(keyword: 'shirt');

      // assert
      expect(result, isA<Right>());
      result.fold(
        (l) => fail('expected Right'),
        (r) => expect(r, equals([fakeProduct])),
      );
    });

    test('should return Right(empty list) when the data source finds no matches',
        () async {
      // arrange
      when(() =>
              mockDataSource.searchProducts(keyword: any(named: 'keyword')))
          .thenAnswer((_) async => []);

      // act
      final result = await sut.searchProducts(keyword: 'nonexistent-item-xyz');

      // assert
      expect(result, isA<Right>());
      result.fold(
        (l) => fail('expected Right'),
        (r) => expect(r, isEmpty),
      );
    });

    test('should call the data source with the given keyword', () async {
      // arrange
      when(() =>
              mockDataSource.searchProducts(keyword: any(named: 'keyword')))
          .thenAnswer((_) async => [fakeProduct]);

      // act
      await sut.searchProducts(keyword: 'shirt');

      // assert
      verify(() => mockDataSource.searchProducts(keyword: 'shirt')).called(1);
    });

    test('should return Left(ServerFailures) with generic message when data source throws Exception',
        () async {
      // arrange
      when(() =>
              mockDataSource.searchProducts(keyword: any(named: 'keyword')))
          .thenThrow(Exception('unexpected'));

      // act
      final result = await sut.searchProducts(keyword: 'shirt');

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

    test('should return Left(ServerFailures) with connection message when data source throws DioException(connectionError)',
        () async {
      // arrange
      when(() =>
              mockDataSource.searchProducts(keyword: any(named: 'keyword')))
          .thenThrow(buildDioException(DioExceptionType.connectionError));

      // act
      final result = await sut.searchProducts(keyword: 'shirt');

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

    test('should return Left(ServerFailures) with timeout message when data source throws DioException(connectionTimeout)',
        () async {
      // arrange
      when(() =>
              mockDataSource.searchProducts(keyword: any(named: 'keyword')))
          .thenThrow(buildDioException(DioExceptionType.connectionTimeout));

      // act
      final result = await sut.searchProducts(keyword: 'shirt');

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

    test('should return Left(ServerFailures) with cancel message when data source throws DioException(cancel)',
        () async {
      // arrange
      when(() =>
              mockDataSource.searchProducts(keyword: any(named: 'keyword')))
          .thenThrow(buildDioException(DioExceptionType.cancel));

      // act
      final result = await sut.searchProducts(keyword: 'shirt');

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

    test('should return Left(ServerFailures) mapped from the response body when data source throws DioException(badResponse) with a 404',
        () async {
      // arrange
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 404,
      );
      when(() =>
              mockDataSource.searchProducts(keyword: any(named: 'keyword')))
          .thenThrow(buildDioException(DioExceptionType.badResponse,
              response: response));

      // act
      final result = await sut.searchProducts(keyword: 'shirt');

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
