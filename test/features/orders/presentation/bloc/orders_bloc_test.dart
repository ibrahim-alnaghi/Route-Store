import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/constants/enums.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/checkout/domain/entities/order_entity.dart';
import 'package:route_store/features/orders/domain/usecases/get_my_orders_use_case.dart';
import 'package:route_store/features/orders/presentation/bloc/orders_bloc.dart';

class MockGetMyOrdersUseCase extends Mock implements GetMyOrdersUseCase {}

void main() {
  late MockGetMyOrdersUseCase mockGetMyOrdersUseCase;

  setUp(() {
    mockGetMyOrdersUseCase = MockGetMyOrdersUseCase();
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

  final fakeFailure = ServerFailures('Could not fetch orders');

  test('initial state is status initial with no orders', () {
    final bloc = OrdersBloc(getMyOrdersUseCase: mockGetMyOrdersUseCase);
    expect(bloc.state, const OrdersState(status: RequestStates.initial));
    bloc.close();
  });

  blocTest<OrdersBloc, OrdersState>(
    'emits [loading, success] with the returned orders when fetching orders succeeds',
    build: () {
      when(() => mockGetMyOrdersUseCase.call())
          .thenAnswer((_) async => const Right(fakeOrders));
      return OrdersBloc(getMyOrdersUseCase: mockGetMyOrdersUseCase);
    },
    act: (bloc) => bloc.add(const GetMyOrders()),
    expect: () => [
      const OrdersState(status: RequestStates.loading),
      const OrdersState(status: RequestStates.success, orders: fakeOrders),
    ],
    verify: (_) {
      verify(() => mockGetMyOrdersUseCase.call()).called(1);
    },
  );

  blocTest<OrdersBloc, OrdersState>(
    'emits [loading, failure] with errorMessage when fetching orders fails',
    build: () {
      when(() => mockGetMyOrdersUseCase.call())
          .thenAnswer((_) async => Left(fakeFailure));
      return OrdersBloc(getMyOrdersUseCase: mockGetMyOrdersUseCase);
    },
    act: (bloc) => bloc.add(const GetMyOrders()),
    expect: () => [
      const OrdersState(status: RequestStates.loading),
      OrdersState(
          status: RequestStates.failure, errorMessage: fakeFailure.message),
    ],
  );
}
