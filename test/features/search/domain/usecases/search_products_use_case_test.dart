import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/search/domain/repositories/search_domain_repo.dart';
import 'package:route_store/features/search/domain/usecases/search_products_use_case.dart';
import 'package:route_store/features/shop/domain/entities/product_entity/product_entity.dart';

class MockSearchDomainRepo extends Mock implements SearchDomainRepo {}

void main() {
  late SearchProductsUseCase sut;
  late MockSearchDomainRepo mockRepo;

  setUp(() {
    mockRepo = MockSearchDomainRepo();
    sut = SearchProductsUseCase(mockRepo);
  });

  const fakeProduct = ProductEntity(
    productID: '1',
    productName: 'Test Product',
    productDescription: 'description',
    productImages: [],
    quantityRatings: 0,
    averageRatings: 0,
    productQuantity: 0,
    productPrice: 100,
    productPriceAfterDiscount: 0,
    discountPercentage: 0,
    productImageCover: '',
    productBrand: '',
    brandImage: '',
  );

  test('delegates to repo.searchProducts with the given keyword on success',
      () async {
    when(() => mockRepo.searchProducts(keyword: any(named: 'keyword')))
        .thenAnswer((_) async => const Right([fakeProduct]));

    final result = await sut.call('shirt');

    expect(result, const Right([fakeProduct]));
    verify(() => mockRepo.searchProducts(keyword: 'shirt')).called(1);
  });

  test('propagates a Failure from the repo when search fails', () async {
    final fakeFailure = ServerFailures('Something went wrong');
    when(() => mockRepo.searchProducts(keyword: any(named: 'keyword')))
        .thenAnswer((_) async => Left(fakeFailure));

    final result = await sut.call('shirt');

    expect(result, Left(fakeFailure));
  });
}
