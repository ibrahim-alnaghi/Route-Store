import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:route_store/core/constants/enums.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_entity.dart';
import 'package:route_store/features/cart/domain/entities/cart_entity/cart_products_entity.dart';
import 'package:route_store/features/cart/domain/usecases/add_product_to_cart_use_case.dart';
import 'package:route_store/features/cart/domain/usecases/apply_coupon_use_case.dart';
import 'package:route_store/features/cart/domain/usecases/get_cart_use_case.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartStates> {
  final GetCartUseCase _getCartUseCase;
  final AddProductToCart _addProductToCart;
  final ApplyCouponUseCase _applyCouponUseCase;
  CartBloc(
      {required GetCartUseCase getCartUseCase,
      required AddProductToCart addProductToCart,
      required ApplyCouponUseCase applyCouponUseCase})
      : _getCartUseCase = getCartUseCase,
        _addProductToCart = addProductToCart,
        _applyCouponUseCase = applyCouponUseCase,
        super(const CartStates(status: RequestStates.initial)) {
    on<GetCart>((event, emit) async {
      await _getCart(emit);
    });
    on<AddToCart>((event, emit) async {
      await _addToCart(event.productId, emit);
    });

    on<UpdateCartProductQuantity>((event, emit) async {
      await _updateCartProductQuantity(event.productId, event.quantity, emit);
    });

    on<RemoveCartItem>((event, emit) async {
      await _removeCartItem(event.productId, emit);
    });
    on<ClearCart>((event, emit) async {
      await _clearCart(emit);
    });
    on<ApplyCoupon>((event, emit) async {
      await _applyCoupon(event.couponCode, emit);
    });
    add(GetCart());
  }

  Future<void> _getCart(Emitter<CartStates> emit) async {
    emit(state.copyWith(status: RequestStates.loading));

    final result = await _getCartUseCase.call();

    result.fold(
      (l) {
        emit(state.copyWith(
            status: RequestStates.failure, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStates.success, cart: r));
      },
    );
  }

  Future<void> _addToCart(String productId, Emitter<CartStates> emit) async {
    // Emit a loading state
    emit(state.copyWith(status: RequestStates.loading));

    final cart = state.cart;
    // Check if the cart is not null
    if (cart != null) {
      final cartItems = cart.cartItems;
      final cartProducts = cartItems.cartProducts;
      // Check if the product is already in the cart
      CartProductsEntity? existingProduct;
      try {
        existingProduct = cartProducts.firstWhere(
          (product) => product.productDetails.productId == productId,
        );
      } catch (e) {
        existingProduct = null;
      }

      // If the product already exists in the cart, update its quantity
      if (existingProduct != null) {
        final updatedQuantity = existingProduct.itemCount + 1;
        add(UpdateCartProductQuantity(productId, updatedQuantity));
      } else {
        // If the product is not in the cart, add it
        final result = await _addProductToCart.call(productId);

        result.fold(
          (l) {
            emit(state.copyWith(
                status: RequestStates.failure, errorMessage: l.message));
          },
          (r) {
            emit(state.copyWith(status: RequestStates.success));
            add(GetCart());
          },
        );
      }
    } else {
      // If the cart is empty, add the product to the cart
      final result = await _addProductToCart.call(productId);

      result.fold(
        (l) {
          emit(state.copyWith(
              status: RequestStates.failure, errorMessage: l.message));
        },
        (r) {
          emit(state.copyWith(status: RequestStates.success));
          add(GetCart());
        },
      );
    }
  }

  Future<void> _updateCartProductQuantity(
      String productId, num quantity, Emitter<CartStates> emit) async {
    // Emit a loading state
    emit(state.copyWith(status: RequestStates.loading));

    final cart = state.cart;
    // Check if the cart is not null
    if (cart != null) {
      final cartItems = cart.cartItems;
      final cartProducts = cartItems.cartProducts;
      // Check if the product is already in the cart
      CartProductsEntity? existingProduct;
      try {
        existingProduct = cartProducts.firstWhere(
          (product) => product.productDetails.productId == productId,
        );
      } catch (e) {
        existingProduct = null;
      }

      // If the product exists in the cart, update its quantity
      if (existingProduct != null) {
        // Update the quantity of the product in the cart
        if (existingProduct.itemCount < 1) {
          // If the updated quantity is less than 1, remove the product from the cart
          add(RemoveCartItem(productId));
          if (cartProducts.isEmpty) {
            add(ClearCart());
          }
        }
      } else {
        // If the product is not in the cart, add it
        add(AddToCart(productId));
      }
    } else {
      // If the cart is empty, add the product to the cart
      add(AddToCart(productId));
    }
  }

  Future<void> _removeCartItem(
      String productId, Emitter<CartStates> emit) async {
    // Add your logic to remove the specific item from the cart here
  }
  Future<void> _clearCart(Emitter<CartStates> emit) async {
    // Add your logic to clear the cart here
  }

  Future<void> _applyCoupon(
      String couponCode, Emitter<CartStates> emit) async {
    final previousTotal = state.cart?.cartItems.totalPrice ?? 0;
    // Bumped on every attempt's outcome (success or failure) so a
    // BlocListener can reliably fire even when two attempts in a row
    // produce the exact same message/error text (e.g. retrying the same
    // invalid coupon) — comparing that text directly would otherwise look
    // like "no change" and silently suppress the second notification.
    final nextVersion = state.couponVersion + 1;
    emit(state.copyWith(status: RequestStates.loading));

    final result = await _applyCouponUseCase.call(couponCode);

    result.fold(
      (l) {
        emit(state.copyWith(
            status: RequestStates.failure,
            couponError: l.message,
            couponVersion: nextVersion));
      },
      (r) {
        final discount = previousTotal - r.cartItems.totalPrice;
        emit(state.copyWith(
            status: RequestStates.success,
            cart: r,
            couponMessage: discount > 0
                ? 'Coupon applied — you saved EGP $discount'
                : 'Coupon applied — new total EGP ${r.cartItems.totalPrice}',
            couponDiscount: discount > 0 ? discount : 0,
            couponVersion: nextVersion));
      },
    );
  }
}
