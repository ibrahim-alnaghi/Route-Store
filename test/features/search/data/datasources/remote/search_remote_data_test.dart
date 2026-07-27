import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/api/api_service.dart';
import 'package:route_store/core/constants/api_constants.dart';
import 'package:route_store/features/search/data/datasources/remote/search_remote_data.dart';
import 'package:route_store/features/shop/data/models/product_model/product_model.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late SearchRemoteData sut;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    sut = SearchRemoteData(mockApiService);
  });

  final productJson = {
    '_id': '1',
    'title': 'Test Shirt',
    'price': 100,
    'priceAfterDiscount': 80,
  };

  void stubApiServiceGet(Map<String, dynamic> response) {
    when(() => mockApiService.get(
          endPoint: any(named: 'endPoint'),
          queryParameters: any(named: 'queryParameters'),
        )).thenAnswer((_) async => response);
  }

  test(
      'calls ApiService.get with the products endpoint and the keyword as a query parameter',
      () async {
    // arrange
    stubApiServiceGet({
      'data': [productJson]
    });

    // act
    await sut.searchProducts(keyword: 'shirt');

    // assert
    verify(() => mockApiService.get(
          endPoint: EndPoints.getAllProducts,
          queryParameters: {'keyword': 'shirt'},
        )).called(1);
  });

  test('parses the response "data" array into a list of ProductModel',
      () async {
    // arrange
    stubApiServiceGet({
      'data': [productJson]
    });

    // act
    final result = await sut.searchProducts(keyword: 'shirt');

    // assert
    expect(result, hasLength(1));
    expect(result.first, isA<ProductModel>());
    expect(result.first.productID, equals('1'));
    expect(result.first.productName, equals('Test Shirt'));
  });

  test('parses multiple items in the response "data" array in order',
      () async {
    // arrange
    stubApiServiceGet({
      'data': [
        productJson,
        {'_id': '2', 'title': 'Another Shirt', 'price': 50},
      ]
    });

    // act
    final result = await sut.searchProducts(keyword: 'shirt');

    // assert
    expect(result, hasLength(2));
    expect(result[0].productID, equals('1'));
    expect(result[1].productID, equals('2'));
  });

  test('returns an empty list when the response "data" array is empty',
      () async {
    // arrange
    stubApiServiceGet({'data': []});

    // act
    final result = await sut.searchProducts(keyword: 'nonexistent-item-xyz');

    // assert
    expect(result, isEmpty);
  });

  test('propagates the exception thrown by ApiService without catching it',
      () async {
    // arrange
    when(() => mockApiService.get(
          endPoint: any(named: 'endPoint'),
          queryParameters: any(named: 'queryParameters'),
        )).thenThrow(Exception('network down'));

    // act & assert
    expect(() => sut.searchProducts(keyword: 'shirt'), throwsException);
  });
}
