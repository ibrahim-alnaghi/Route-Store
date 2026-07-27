part of 'cart_bloc.dart';

class CartStates extends Equatable {
  final RequestStates status;
  final String? errorMessage;
  final CartEntity? cart;
  final String? couponMessage;
  final String? couponError;
  final num? couponDiscount;
  final int couponVersion;

  const CartStates({
    required this.status,
    this.errorMessage,
    this.cart,
    this.couponMessage,
    this.couponError,
    this.couponDiscount,
    this.couponVersion = 0,
  });

  CartStates copyWith(
      {RequestStates? status,
      String? errorMessage,
      CartEntity? cart,
      String? couponMessage,
      String? couponError,
      num? couponDiscount,
      int? couponVersion}) {
    return CartStates(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      cart: cart ?? this.cart,
      couponMessage: couponMessage ?? this.couponMessage,
      couponError: couponError ?? this.couponError,
      couponDiscount: couponDiscount ?? this.couponDiscount,
      couponVersion: couponVersion ?? this.couponVersion,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        cart,
        couponMessage,
        couponError,
        couponDiscount,
        couponVersion
      ];
}
