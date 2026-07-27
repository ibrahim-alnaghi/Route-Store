import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/cart/domain/repositories/cart_domain_repo.dart';
import 'package:route_store/features/cart/domain/usecases/remove_cart_item_use_case.dart';

class MockCartDomainRepo extends Mock implements CartDomainRepo {}

void main() {
  late RemoveCartItemUseCase sut;
  late MockCartDomainRepo mockRepo;

  setUp(() {
    mockRepo = MockCartDomainRepo();
    sut = RemoveCartItemUseCase(mockRepo);
  });

  test('delegates to repo.removeCartItem with the given productId on success',
      () async {
    when(() => mockRepo.removeCartItem(any()))
        .thenAnswer((_) async => const Right(null));

    final result = await sut.call('product1');

    expect(result, const Right(null));
    verify(() => mockRepo.removeCartItem('product1')).called(1);
  });

  test('propagates a Failure from the repo when removing the item fails',
      () async {
    final fakeFailure = ServerFailures('Could not remove item');
    when(() => mockRepo.removeCartItem(any()))
        .thenAnswer((_) async => Left(fakeFailure));

    final result = await sut.call('product1');

    expect(result, Left(fakeFailure));
  });
}
