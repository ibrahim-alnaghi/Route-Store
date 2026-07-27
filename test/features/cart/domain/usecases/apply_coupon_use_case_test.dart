import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_entity.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_items.dart';
import 'package:route_store/features/cart/domain/repositories/cart_domain_repo.dart';
import 'package:route_store/features/cart/domain/usecases/apply_coupon_use_case.dart';

class MockCartDomainRepo extends Mock implements CartDomainRepo {}

void main() {
  late ApplyCouponUseCase sut;
  late MockCartDomainRepo mockRepo;

  setUp(() {
    mockRepo = MockCartDomainRepo();
    sut = ApplyCouponUseCase(mockRepo);
  });

  const fakeCart = CartEntity(
    cartItemsCount: 1,
    cartItems: CartItemsEntity(cartId: 'cart1', cartProducts: [], totalPrice: 80),
  );

  test('delegates to repo.applyCoupon with the given coupon code on success',
      () async {
    when(() => mockRepo.applyCoupon(any()))
        .thenAnswer((_) async => const Right(fakeCart));

    final result = await sut.call('SAVE20');

    expect(result, const Right(fakeCart));
    verify(() => mockRepo.applyCoupon('SAVE20')).called(1);
  });

  test('propagates a Failure from the repo when applying the coupon fails',
      () async {
    final fakeFailure = ServerFailures('Invalid coupon');
    when(() => mockRepo.applyCoupon(any()))
        .thenAnswer((_) async => Left(fakeFailure));

    final result = await sut.call('INVALID');

    expect(result, Left(fakeFailure));
  });
}
