import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/constants/enums.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/search/domain/usecases/search_products_use_case.dart';
import 'package:route_store/features/search/presentation/blocs/search/search_bloc.dart';
import 'package:route_store/features/shop/domain/entities/product_entity/product_entity.dart';

class MockSearchProductsUseCase extends Mock implements SearchProductsUseCase {}

void main() {
  late MockSearchProductsUseCase mockSearchProductsUseCase;

  setUp(() {
    mockSearchProductsUseCase = MockSearchProductsUseCase();
  });

  const fakeProduct = ProductEntity(
    productID: '1',
    productName: 'Shirt',
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
  final fakeFailure = ServerFailures('Search failed');

  test('initial state is status initial with an empty query', () {
    final bloc = SearchBloc(searchProductsUseCase: mockSearchProductsUseCase);
    expect(bloc.state,
        const SearchStates(status: RequestStates.initial, query: ''));
    bloc.close();
  });

  blocTest<SearchBloc, SearchStates>(
    'emits only initial/empty state when query is empty, no use case call',
    build: () => SearchBloc(searchProductsUseCase: mockSearchProductsUseCase),
    act: (bloc) => bloc.add(const SearchQueryChanged('')),
    expect: () => [
      const SearchStates(status: RequestStates.initial, query: ''),
      const SearchStates(status: RequestStates.initial, query: '', results: []),
    ],
    verify: (_) {
      verifyNever(() => mockSearchProductsUseCase.call(any()));
    },
  );

  blocTest<SearchBloc, SearchStates>(
    'emits [loading, success] after the debounce delay fires for a query',
    build: () {
      when(() => mockSearchProductsUseCase.call(any()))
          .thenAnswer((_) async => const Right([fakeProduct]));
      return SearchBloc(searchProductsUseCase: mockSearchProductsUseCase);
    },
    act: (bloc) => bloc.add(const SearchQueryChanged('shirt')),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const SearchStates(status: RequestStates.initial, query: 'shirt'),
      const SearchStates(status: RequestStates.loading, query: 'shirt'),
      const SearchStates(
          status: RequestStates.success, query: 'shirt', results: [fakeProduct]),
    ],
    verify: (_) {
      verify(() => mockSearchProductsUseCase.call('shirt')).called(1);
    },
  );

  blocTest<SearchBloc, SearchStates>(
    'only the last query within the debounce window triggers a search call',
    build: () {
      when(() => mockSearchProductsUseCase.call(any()))
          .thenAnswer((_) async => const Right([fakeProduct]));
      return SearchBloc(searchProductsUseCase: mockSearchProductsUseCase);
    },
    act: (bloc) async {
      bloc.add(const SearchQueryChanged('s'));
      bloc.add(const SearchQueryChanged('sh'));
      bloc.add(const SearchQueryChanged('shi'));
      bloc.add(const SearchQueryChanged('shirt'));
    },
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const SearchStates(status: RequestStates.initial, query: 's'),
      const SearchStates(status: RequestStates.initial, query: 'sh'),
      const SearchStates(status: RequestStates.initial, query: 'shi'),
      const SearchStates(status: RequestStates.initial, query: 'shirt'),
      const SearchStates(status: RequestStates.loading, query: 'shirt'),
      const SearchStates(
          status: RequestStates.success, query: 'shirt', results: [fakeProduct]),
    ],
    verify: (_) {
      verify(() => mockSearchProductsUseCase.call('shirt')).called(1);
      verifyNever(() => mockSearchProductsUseCase.call('s'));
      verifyNever(() => mockSearchProductsUseCase.call('sh'));
      verifyNever(() => mockSearchProductsUseCase.call('shi'));
    },
  );

  blocTest<SearchBloc, SearchStates>(
    'clearing the query before the debounce fires cancels the pending search entirely',
    build: () => SearchBloc(searchProductsUseCase: mockSearchProductsUseCase),
    act: (bloc) async {
      bloc.add(const SearchQueryChanged('sh'));
      // Cleared well within the 500ms debounce window, before it can fire.
      bloc.add(const SearchQueryChanged(''));
    },
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const SearchStates(status: RequestStates.initial, query: 'sh'),
      const SearchStates(status: RequestStates.initial, query: ''),
      const SearchStates(status: RequestStates.initial, query: '', results: []),
    ],
    verify: (_) {
      verifyNever(() => mockSearchProductsUseCase.call(any()));
    },
  );

  blocTest<SearchBloc, SearchStates>(
    'emits [loading, failure] with errorMessage when the search fails',
    build: () {
      when(() => mockSearchProductsUseCase.call(any()))
          .thenAnswer((_) async => Left(fakeFailure));
      return SearchBloc(searchProductsUseCase: mockSearchProductsUseCase);
    },
    act: (bloc) => bloc.add(const SearchQueryChanged('shirt')),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const SearchStates(status: RequestStates.initial, query: 'shirt'),
      const SearchStates(status: RequestStates.loading, query: 'shirt'),
      SearchStates(
          status: RequestStates.failure,
          query: 'shirt',
          errorMessage: fakeFailure.message),
    ],
  );

  test('close() cancels the pending debounce timer so the use case is never invoked',
      () async {
    // arrange
    final bloc = SearchBloc(searchProductsUseCase: mockSearchProductsUseCase);

    // act
    bloc.add(const SearchQueryChanged('shirt'));
    // Let the event handler run so the debounce Timer is actually started
    // before we close the bloc - otherwise there is nothing pending to cancel.
    await Future.delayed(const Duration(milliseconds: 50));
    await bloc.close();
    // Wait past the 500ms debounce window to prove the timer never fired.
    await Future.delayed(const Duration(milliseconds: 600));

    // assert
    verifyNever(() => mockSearchProductsUseCase.call(any()));
  });
}
