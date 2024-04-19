part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class AddToFav extends WishlistEvent {
  final String productID;

  const AddToFav({required this.productID});

  @override
  List<Object> get props => [productID];
}

class GetFav extends WishlistEvent {}

class RemoveFromFav extends WishlistEvent {
  final String productID;

  const RemoveFromFav({required this.productID});

  @override
  List<Object> get props => [productID];
}

class ChangeFav extends WishlistEvent {
  final String productID;

  const ChangeFav({required this.productID});

  @override
  List<Object> get props => [productID];
}
