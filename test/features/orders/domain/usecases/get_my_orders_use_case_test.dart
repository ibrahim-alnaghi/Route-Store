import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/checkout/domain/entities/order_entity.dart';
import 'package:route_store/features/orders/domain/repositories/orders_domain_repo.dart';
import 'package:route_store/features/orders/domain/usecases/get_my_orders_use_case.dart';

class MockOrdersDomainRepo extends Mock implements OrdersDomainRepo {}

void main() {
  late GetMyOrdersUseCase sut;
  late MockOrdersDomainRepo mockRepo;

  setUp(() {
    mockRepo = MockOrdersDomainRepo();
    sut = GetMyOrdersUseCase(mockRepo);
  });

  const fakeOrders = [
    OrderEntity(
      orderId: 'order1',
      cartId: 'cart1',
      totalOrderPrice: 250,
      paymentMethodType: 'cash',
      isPaid: false,
      isDelivered: false,
    ),
  ];

  test('delegates to repo.getMyOrders with no arguments on success',
      () async {
    // arrange
    when(() => mockRepo.getMyOrders())
        .thenAnswer((_) async => const Right(fakeOrders));

    // act
    final result = await sut.call();

    // assert
    expect(result, const Right(fakeOrders));
    verify(() => mockRepo.getMyOrders()).called(1);
  });

  test('propagates a Failure from the repo when fetching orders fails',
      () async {
    // arrange
    final fakeFailure = ServerFailures('Something went wrong');
    when(() => mockRepo.getMyOrders())
        .thenAnswer((_) async => Left(fakeFailure));

    // act
    final result = await sut.call();

    // assert
    expect(result, Left(fakeFailure));
  });
}
