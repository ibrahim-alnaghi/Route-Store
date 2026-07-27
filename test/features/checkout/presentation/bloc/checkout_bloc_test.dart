import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/constants/enums.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/checkout/data/models/place_order_request_body.dart';
import 'package:route_store/features/checkout/domain/entities/order_entity.dart';
import 'package:route_store/features/checkout/domain/usecases/place_order_use_case.dart';
import 'package:route_store/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:route_store/features/personalization/domain/entities/adress_entity.dart';

class MockPlaceOrderUseCase extends Mock implements PlaceOrderUseCase {}

class FakePlaceOrderRequestBody extends Fake implements PlaceOrderRequestBody {}

void main() {
  late MockPlaceOrderUseCase mockPlaceOrderUseCase;

  setUpAll(() {
    registerFallbackValue(FakePlaceOrderRequestBody());
  });

  setUp(() {
    mockPlaceOrderUseCase = MockPlaceOrderUseCase();
  });

  const shippingAddress = AdressEntity(
    adressID: 'addr1',
    adressName: 'Home',
    adressDetails: 'Street 1, Area 1',
    adressPhone: '01000000000',
    adressCity: 'Cairo',
  );

  const fakeOrder = OrderEntity(
    orderId: 'order1',
    cartId: 'cart1',
    totalOrderPrice: 250,
    paymentMethodType: 'cash',
    isPaid: false,
    isDelivered: false,
  );

  final fakeFailure = ServerFailures('Could not place order');

  test('initial state is status initial with no order', () {
    final bloc = CheckoutBloc(placeOrderUseCase: mockPlaceOrderUseCase);
    expect(bloc.state, const CheckoutState(status: RequestStates.initial));
    bloc.close();
  });

  blocTest<CheckoutBloc, CheckoutState>(
    'emits [loading, success] with the returned order when placing the order succeeds',
    build: () {
      when(() => mockPlaceOrderUseCase.call(any()))
          .thenAnswer((_) async => const Right(fakeOrder));
      return CheckoutBloc(placeOrderUseCase: mockPlaceOrderUseCase);
    },
    act: (bloc) => bloc.add(const PlaceOrder(
      cartId: 'cart1',
      shippingAddress: shippingAddress,
    )),
    expect: () => [
      const CheckoutState(status: RequestStates.loading),
      const CheckoutState(status: RequestStates.success, order: fakeOrder),
    ],
    verify: (_) {
      final captured = verify(() => mockPlaceOrderUseCase.call(captureAny()))
          .captured
          .single as PlaceOrderRequestBody;
      expect(captured.cartId, equals('cart1'));
      expect(captured.details, equals(shippingAddress.adressDetails));
      expect(captured.phone, equals(shippingAddress.adressPhone));
      expect(captured.city, equals(shippingAddress.adressCity));
    },
  );

  blocTest<CheckoutBloc, CheckoutState>(
    'emits [loading, failure] with errorMessage when placing the order fails',
    build: () {
      when(() => mockPlaceOrderUseCase.call(any()))
          .thenAnswer((_) async => Left(fakeFailure));
      return CheckoutBloc(placeOrderUseCase: mockPlaceOrderUseCase);
    },
    act: (bloc) => bloc.add(const PlaceOrder(
      cartId: 'cart1',
      shippingAddress: shippingAddress,
    )),
    expect: () => [
      const CheckoutState(status: RequestStates.loading),
      CheckoutState(
          status: RequestStates.failure, errorMessage: fakeFailure.message),
    ],
  );
}
