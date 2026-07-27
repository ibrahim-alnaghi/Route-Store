import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/cart/domain/repositories/cart_domain_repo.dart';
import 'package:route_store/features/cart/domain/usecases/update_cart_product_quantity_use_case.dart';

class MockCartDomainRepo extends Mock implements CartDomainRepo {}

void main() {
  late UpdateCartProductQuantityUseCase sut;
  late MockCartDomainRepo mockRepo;

  setUp(() {
    mockRepo = MockCartDomainRepo();
    sut = UpdateCartProductQuantityUseCase(mockRepo);
  });

  test(
      'delegates to repo.updateCartProductQuantity with the productId and quantity from the params, in the correct order, on success',
      () async {
    when(() => mockRepo.updateCartProductQuantity(any(), any()))
        .thenAnswer((_) async => const Right(null));

    final result = await sut.call(
      const UpdateCartQuantityParams(productId: 'product1', quantity: 3),
    );

    expect(result, const Right(null));
    verify(() => mockRepo.updateCartProductQuantity('product1', 3)).called(1);
  });

  test(
      'propagates a Failure from the repo when updating the quantity fails',
      () async {
    final fakeFailure = ServerFailures('Could not update quantity');
    when(() => mockRepo.updateCartProductQuantity(any(), any()))
        .thenAnswer((_) async => Left(fakeFailure));

    final result = await sut.call(
      const UpdateCartQuantityParams(productId: 'product1', quantity: 3),
    );

    expect(result, Left(fakeFailure));
  });
}
