import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/constants/enums.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_entity.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_items.dart';
import 'package:route_store/features/cart/domain/usecases/add_product_to_cart_use_case.dart';
import 'package:route_store/features/cart/domain/usecases/apply_coupon_use_case.dart';
import 'package:route_store/features/cart/domain/usecases/clear_cart_use_case.dart';
import 'package:route_store/features/cart/domain/usecases/get_cart_use_case.dart';
import 'package:route_store/features/cart/domain/usecases/remove_cart_item_use_case.dart';
import 'package:route_store/features/cart/domain/usecases/update_cart_product_quantity_use_case.dart';
import 'package:route_store/features/cart/presentation/bloc/cart_bloc.dart';

class MockGetCartUseCase extends Mock implements GetCartUseCase {}

class MockAddProductToCart extends Mock implements AddProductToCart {}

class MockApplyCouponUseCase extends Mock implements ApplyCouponUseCase {}

class MockRemoveCartItemUseCase extends Mock implements RemoveCartItemUseCase {}

class MockUpdateCartProductQuantityUseCase extends Mock
    implements UpdateCartProductQuantityUseCase {}

class MockClearCartUseCase extends Mock implements ClearCartUseCase {}

void main() {
  late MockGetCartUseCase mockGetCartUseCase;
  late MockAddProductToCart mockAddProductToCart;
  late MockApplyCouponUseCase mockApplyCouponUseCase;
  late MockRemoveCartItemUseCase mockRemoveCartItemUseCase;
  late MockUpdateCartProductQuantityUseCase mockUpdateCartProductQuantityUseCase;
  late MockClearCartUseCase mockClearCartUseCase;

  setUpAll(() {
    registerFallbackValue(
        const UpdateCartQuantityParams(productId: '', quantity: 0));
  });

  setUp(() {
    mockGetCartUseCase = MockGetCartUseCase();
    mockAddProductToCart = MockAddProductToCart();
    mockApplyCouponUseCase = MockApplyCouponUseCase();
    mockRemoveCartItemUseCase = MockRemoveCartItemUseCase();
    mockUpdateCartProductQuantityUseCase =
        MockUpdateCartProductQuantityUseCase();
    mockClearCartUseCase = MockClearCartUseCase();
  });

  CartBloc buildBloc() => CartBloc(
        getCartUseCase: mockGetCartUseCase,
        addProductToCart: mockAddProductToCart,
        applyCouponUseCase: mockApplyCouponUseCase,
        removeCartItemUseCase: mockRemoveCartItemUseCase,
        updateCartProductQuantityUseCase: mockUpdateCartProductQuantityUseCase,
        clearCartUseCase: mockClearCartUseCase,
      );

  const initialCart = CartEntity(
    cartItemsCount: 2,
    cartItems:
        CartItemsEntity(cartId: 'cart1', cartProducts: [], totalPrice: 100),
  );
  const couponCart = CartEntity(
    cartItemsCount: 2,
    cartItems:
        CartItemsEntity(cartId: 'cart1', cartProducts: [], totalPrice: 80),
  );
  final fakeFailure = ServerFailures('Something went wrong');

  group('CartBloc - GetCart (fired automatically on construction)', () {
    test('initial state is status initial with no cart', () {
      when(() => mockGetCartUseCase.call())
          .thenAnswer((_) async => const Right(initialCart));

      final bloc = buildBloc();

      expect(bloc.state, const CartStates(status: RequestStates.initial));
      bloc.close();
    });

    blocTest<CartBloc, CartStates>(
      'emits [loading, success] with the fetched cart when GetCart succeeds',
      build: () {
        when(() => mockGetCartUseCase.call())
            .thenAnswer((_) async => const Right(initialCart));
        return buildBloc();
      },
      act: (_) {},
      expect: () => [
        const CartStates(status: RequestStates.loading),
        const CartStates(status: RequestStates.success, cart: initialCart),
      ],
    );

    blocTest<CartBloc, CartStates>(
      'emits [loading, failure] with errorMessage when GetCart fails',
      build: () {
        when(() => mockGetCartUseCase.call())
            .thenAnswer((_) async => Left(fakeFailure));
        return buildBloc();
      },
      act: (_) {},
      expect: () => [
        const CartStates(status: RequestStates.loading),
        CartStates(
            status: RequestStates.failure, errorMessage: fakeFailure.message),
      ],
    );
  });

  group('CartBloc - ApplyCoupon', () {
    blocTest<CartBloc, CartStates>(
      'emits [loading, success(cart:, couponMessage:)] when applying the coupon succeeds',
      build: () {
        when(() => mockGetCartUseCase.call())
            .thenAnswer((_) async => const Right(initialCart));
        when(() => mockApplyCouponUseCase.call(any()))
            .thenAnswer((_) async => const Right(couponCart));
        return buildBloc();
      },
      skip: 2, // skip the [loading, success] states from the automatic GetCart
      act: (bloc) async {
        // Let the automatic GetCart triggered by the constructor fully
        // settle before dispatching ApplyCoupon, so the two flows don't
        // interleave.
        await Future.delayed(Duration.zero);
        bloc.add(const ApplyCoupon('SAVE20'));
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const CartStates(status: RequestStates.loading, cart: initialCart),
        const CartStates(
            status: RequestStates.success,
            cart: couponCart,
            couponMessage: 'Coupon applied — you saved EGP 20',
            couponDiscount: 20,
            couponVersion: 1),
      ],
      verify: (_) {
        verify(() => mockApplyCouponUseCase.call('SAVE20')).called(1);
      },
    );

    blocTest<CartBloc, CartStates>(
      'emits [loading, failure(couponError:)] when applying the coupon fails',
      build: () {
        when(() => mockGetCartUseCase.call())
            .thenAnswer((_) async => const Right(initialCart));
        when(() => mockApplyCouponUseCase.call(any()))
            .thenAnswer((_) async => Left(fakeFailure));
        return buildBloc();
      },
      skip: 2,
      act: (bloc) async {
        await Future.delayed(Duration.zero);
        bloc.add(const ApplyCoupon('INVALID'));
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const CartStates(status: RequestStates.loading, cart: initialCart),
        CartStates(
            status: RequestStates.failure,
            cart: initialCart,
            couponError: fakeFailure.message,
            couponVersion: 1),
      ],
    );

    blocTest<CartBloc, CartStates>(
      'bumps couponVersion on every attempt, even when the resulting error '
      'text is identical, so a listener keyed on couponVersion still fires',
      build: () {
        when(() => mockGetCartUseCase.call())
            .thenAnswer((_) async => const Right(initialCart));
        when(() => mockApplyCouponUseCase.call(any()))
            .thenAnswer((_) async => Left(fakeFailure));
        return buildBloc();
      },
      skip: 2,
      act: (bloc) async {
        await Future.delayed(Duration.zero);
        bloc.add(const ApplyCoupon('INVALID'));
        await Future.delayed(const Duration(milliseconds: 50));
        bloc.add(const ApplyCoupon('INVALID'));
      },
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.couponVersion, 2);
        expect(bloc.state.couponError, fakeFailure.message);
      },
    );
  });

  group('CartBloc - RemoveCartItem', () {
    blocTest<CartBloc, CartStates>(
      'emits [loading, success] with the refetched cart when removing the item succeeds',
      build: () {
        when(() => mockGetCartUseCase.call())
            .thenAnswer((_) async => const Right(initialCart));
        when(() => mockRemoveCartItemUseCase.call(any()))
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      skip: 2, // skip the [loading, success] states from the automatic GetCart
      act: (bloc) async {
        // Let the automatic GetCart triggered by the constructor fully
        // settle before dispatching RemoveCartItem, so the two flows don't
        // interleave.
        await Future.delayed(Duration.zero);
        bloc.add(const RemoveCartItem('product1'));
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const CartStates(status: RequestStates.loading, cart: initialCart),
        const CartStates(status: RequestStates.success, cart: initialCart),
      ],
      verify: (_) {
        verify(() => mockRemoveCartItemUseCase.call('product1')).called(1);
        verify(() => mockGetCartUseCase.call()).called(2);
      },
    );

    blocTest<CartBloc, CartStates>(
      'emits [loading, failure] with errorMessage and does not refetch the cart when removing the item fails',
      build: () {
        when(() => mockGetCartUseCase.call())
            .thenAnswer((_) async => const Right(initialCart));
        when(() => mockRemoveCartItemUseCase.call(any()))
            .thenAnswer((_) async => Left(fakeFailure));
        return buildBloc();
      },
      skip: 2,
      act: (bloc) async {
        await Future.delayed(Duration.zero);
        bloc.add(const RemoveCartItem('product1'));
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const CartStates(status: RequestStates.loading, cart: initialCart),
        CartStates(
            status: RequestStates.failure,
            cart: initialCart,
            errorMessage: fakeFailure.message),
      ],
      verify: (_) {
        verify(() => mockRemoveCartItemUseCase.call('product1')).called(1);
        // Only the automatic GetCart from construction — no refetch on failure.
        verify(() => mockGetCartUseCase.call()).called(1);
      },
    );
  });

  group('CartBloc - ClearCart', () {
    blocTest<CartBloc, CartStates>(
      'emits [loading, success] with the refetched cart when clearing the cart succeeds',
      build: () {
        when(() => mockGetCartUseCase.call())
            .thenAnswer((_) async => const Right(initialCart));
        when(() => mockClearCartUseCase.call())
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      skip: 2,
      act: (bloc) async {
        await Future.delayed(Duration.zero);
        bloc.add(ClearCart());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const CartStates(status: RequestStates.loading, cart: initialCart),
        const CartStates(status: RequestStates.success, cart: initialCart),
      ],
      verify: (_) {
        verify(() => mockClearCartUseCase.call()).called(1);
        verify(() => mockGetCartUseCase.call()).called(2);
      },
    );

    blocTest<CartBloc, CartStates>(
      'emits [loading, failure] with errorMessage and does not refetch the cart when clearing the cart fails',
      build: () {
        when(() => mockGetCartUseCase.call())
            .thenAnswer((_) async => const Right(initialCart));
        when(() => mockClearCartUseCase.call())
            .thenAnswer((_) async => Left(fakeFailure));
        return buildBloc();
      },
      skip: 2,
      act: (bloc) async {
        await Future.delayed(Duration.zero);
        bloc.add(ClearCart());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const CartStates(status: RequestStates.loading, cart: initialCart),
        CartStates(
            status: RequestStates.failure,
            cart: initialCart,
            errorMessage: fakeFailure.message),
      ],
      verify: (_) {
        verify(() => mockClearCartUseCase.call()).called(1);
        verify(() => mockGetCartUseCase.call()).called(1);
      },
    );
  });

  group('CartBloc - UpdateCartProductQuantity', () {
    blocTest<CartBloc, CartStates>(
      'emits [loading, success] with the refetched cart and calls the use case with the correct params when quantity >= 1 and the update succeeds',
      build: () {
        when(() => mockGetCartUseCase.call())
            .thenAnswer((_) async => const Right(initialCart));
        when(() => mockUpdateCartProductQuantityUseCase.call(any()))
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      skip: 2,
      act: (bloc) async {
        await Future.delayed(Duration.zero);
        bloc.add(const UpdateCartProductQuantity('product1', 3));
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const CartStates(status: RequestStates.loading, cart: initialCart),
        const CartStates(status: RequestStates.success, cart: initialCart),
      ],
      verify: (_) {
        verify(() => mockUpdateCartProductQuantityUseCase.call(
            const UpdateCartQuantityParams(
                productId: 'product1', quantity: 3))).called(1);
        verify(() => mockGetCartUseCase.call()).called(2);
      },
    );

    blocTest<CartBloc, CartStates>(
      'emits [loading, failure] with errorMessage and does not refetch the cart when quantity >= 1 and the update fails',
      build: () {
        when(() => mockGetCartUseCase.call())
            .thenAnswer((_) async => const Right(initialCart));
        when(() => mockUpdateCartProductQuantityUseCase.call(any()))
            .thenAnswer((_) async => Left(fakeFailure));
        return buildBloc();
      },
      skip: 2,
      act: (bloc) async {
        await Future.delayed(Duration.zero);
        bloc.add(const UpdateCartProductQuantity('product1', 3));
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const CartStates(status: RequestStates.loading, cart: initialCart),
        CartStates(
            status: RequestStates.failure,
            cart: initialCart,
            errorMessage: fakeFailure.message),
      ],
      verify: (_) {
        verify(() => mockUpdateCartProductQuantityUseCase.call(
            const UpdateCartQuantityParams(
                productId: 'product1', quantity: 3))).called(1);
        verify(() => mockGetCartUseCase.call()).called(1);
      },
    );

    blocTest<CartBloc, CartStates>(
      'delegates to RemoveCartItem (and never calls UpdateCartProductQuantityUseCase) when quantity < 1',
      build: () {
        when(() => mockGetCartUseCase.call())
            .thenAnswer((_) async => const Right(initialCart));
        when(() => mockRemoveCartItemUseCase.call(any()))
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      skip: 2,
      act: (bloc) async {
        await Future.delayed(Duration.zero);
        bloc.add(const UpdateCartProductQuantity('product1', 0));
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const CartStates(status: RequestStates.loading, cart: initialCart),
        const CartStates(status: RequestStates.success, cart: initialCart),
      ],
      verify: (_) {
        verify(() => mockRemoveCartItemUseCase.call('product1')).called(1);
        verifyNever(() => mockUpdateCartProductQuantityUseCase.call(any()));
      },
    );
  });
}
