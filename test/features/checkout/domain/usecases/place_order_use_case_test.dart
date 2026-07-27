import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/checkout/data/models/place_order_request_body.dart';
import 'package:route_store/features/checkout/domain/entities/order_entity.dart';
import 'package:route_store/features/checkout/domain/repositories/checkout_domain_repo.dart';
import 'package:route_store/features/checkout/domain/usecases/place_order_use_case.dart';

class MockCheckoutDomainRepo extends Mock implements CheckoutDomainRepo {}

class FakePlaceOrderRequestBody extends Fake implements PlaceOrderRequestBody {}

void main() {
  late PlaceOrderUseCase sut;
  late MockCheckoutDomainRepo mockRepo;

  setUpAll(() {
    registerFallbackValue(FakePlaceOrderRequestBody());
  });

  setUp(() {
    mockRepo = MockCheckoutDomainRepo();
    sut = PlaceOrderUseCase(mockRepo);
  });

  const fakeOrder = OrderEntity(
    orderId: '1',
    cartId: 'cart1',
    totalOrderPrice: 100,
    paymentMethodType: 'cash',
    isPaid: false,
    isDelivered: false,
  );

  final requestBody = PlaceOrderRequestBody(
    cartId: 'cart1',
    details: 'street 1',
    phone: '01000000000',
    city: 'Cairo',
  );

  test('delegates to repo.placeOrder with the exact request body on success',
      () async {
    when(() => mockRepo.placeOrder(any()))
        .thenAnswer((_) async => const Right(fakeOrder));

    final result = await sut.call(requestBody);

    expect(result, const Right(fakeOrder));
    verify(() => mockRepo.placeOrder(requestBody)).called(1);
  });

  test('propagates a Failure from the repo when placing the order fails',
      () async {
    final fakeFailure = ServerFailures('Something went wrong');
    when(() => mockRepo.placeOrder(any()))
        .thenAnswer((_) async => Left(fakeFailure));

    final result = await sut.call(requestBody);

    expect(result, Left(fakeFailure));
  });
}
