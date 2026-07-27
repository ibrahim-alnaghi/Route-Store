import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/cart/domain/repositories/cart_domain_repo.dart';
import 'package:route_store/features/cart/domain/usecases/clear_cart_use_case.dart';

class MockCartDomainRepo extends Mock implements CartDomainRepo {}

void main() {
  late ClearCartUseCase sut;
  late MockCartDomainRepo mockRepo;

  setUp(() {
    mockRepo = MockCartDomainRepo();
    sut = ClearCartUseCase(mockRepo);
  });

  test('delegates to repo.clearCart on success', () async {
    when(() => mockRepo.clearCart()).thenAnswer((_) async => const Right(null));

    final result = await sut.call();

    expect(result, const Right(null));
    verify(() => mockRepo.clearCart()).called(1);
  });

  test('propagates a Failure from the repo when clearing the cart fails',
      () async {
    final fakeFailure = ServerFailures('Could not clear cart');
    when(() => mockRepo.clearCart()).thenAnswer((_) async => Left(fakeFailure));

    final result = await sut.call();

    expect(result, Left(fakeFailure));
  });
}
