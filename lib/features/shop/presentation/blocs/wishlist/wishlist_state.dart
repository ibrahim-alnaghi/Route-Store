part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  final Map<String, bool> favorites;
  final List<ProductEntity> products;

  const WishlistState({required this.favorites, required this.products});

  @override
  List<Object> get props => [favorites, products];
}

class WishlistInitial extends WishlistState {
  const WishlistInitial({required super.favorites, required super.products});
  @override
  List<Object> get props => [favorites, products];
}

class AddToFavSuccessState extends WishlistState {
  const AddToFavSuccessState(
      {required super.favorites, required super.products});

  @override
  List<Object> get props => [favorites, products];
}

class AddToFavErrorState extends WishlistState {
  final String message;

  const AddToFavErrorState(
      {required this.message,
      required super.favorites,
      required super.products});

  @override
  List<Object> get props => [message, favorites, products];
}

class RemoveFavSuccessState extends WishlistState {
  const RemoveFavSuccessState(
      {required super.favorites, required super.products});

  @override
  List<Object> get props => [favorites, products];
}

class RemoveFavErrorState extends WishlistState {
  final String message;

  const RemoveFavErrorState(
      {required this.message,
      required super.favorites,
      required super.products});

  @override
  List<Object> get props => [message, favorites, products];
}

class ToggleState extends WishlistState {
  const ToggleState({required super.favorites, required super.products});
  @override
  List<Object> get props => [favorites, products];
}

class GetFavSuccessState extends WishlistState {
  const GetFavSuccessState({required super.favorites, required super.products});

  @override
  List<Object> get props => [products, favorites];
}

class GetFavErrorState extends WishlistState {
  final String message;

  const GetFavErrorState(
      {required this.message,
      required super.favorites,
      required super.products});

  @override
  List<Object> get props => [message, favorites, products];
}
