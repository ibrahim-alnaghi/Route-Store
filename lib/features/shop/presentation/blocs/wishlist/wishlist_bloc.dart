import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/product_entity/product_entity.dart';
import '../../../domain/usecases/add_to_fav_use_case.dart';
import '../../../domain/usecases/get_fav_use_case.dart';
import '../../../domain/usecases/remove_from_fav_use_case.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final AddToFavUseCase _addToFavUseCase;
  final RemoveFromFavUseCase _removeFromFavUseCase;
  final GetFavUseCase _getFavUseCase;

  WishlistBloc({
    required AddToFavUseCase addToFavUseCase,
    required RemoveFromFavUseCase removeFromFavUseCase,
    required GetFavUseCase getFavUseCase,
  })  : _addToFavUseCase = addToFavUseCase,
        _removeFromFavUseCase = removeFromFavUseCase,
        _getFavUseCase = getFavUseCase,
        super(const WishlistInitial(favorites: {}, products: [])) {
    on<AddToFav>(_mapAddToFavToState);
    on<RemoveFromFav>(_mapRemoveFromFavToState);
    on<GetFav>(_mapGetFavToState);
    on<ChangeFav>(_mapChangeFavToState);

    add(GetFav());
  }

  void _mapAddToFavToState(AddToFav event, Emitter<WishlistState> emit) async {
    final result = await _addToFavUseCase(event.productID);
    result.fold(
      (failure) {
        Map<String, bool> updatedFavorites = Map.from(state.favorites);
        updatedFavorites.remove(event.productID);
        emit(AddToFavErrorState(
            message: 'Failed to add to favorites.',
            favorites: updatedFavorites,
            products: state.products));
      },
      (success) {
        emit(AddToFavSuccessState(
            favorites: state.favorites, products: state.products));
        add(GetFav());
      },
    );
  }

  void _mapRemoveFromFavToState(
      RemoveFromFav event, Emitter<WishlistState> emit) async {
    final result = await _removeFromFavUseCase(event.productID);
    result.fold(
      (failure) {
        Map<String, bool> updatedFavorites = Map.from(state.favorites);
        updatedFavorites[event.productID] = true;
        emit(RemoveFavErrorState(
            message: 'Failed to remove from favorites.',
            favorites: updatedFavorites,
            products: state.products));
      },
      (success) {
        emit(RemoveFavSuccessState(
            favorites: state.favorites, products: state.products));
        add(GetFav());
      },
    );
  }

  void _mapGetFavToState(GetFav event, Emitter<WishlistState> emit) async {
    final result = await _getFavUseCase();
    result.fold(
      (failure) => emit(GetFavErrorState(
          message: 'Failed to get favorites.',
          favorites: state.favorites,
          products: state.products)),
      (products) {
        Map<String, bool> favoritesMap = {};
        for (ProductEntity product in products) {
          favoritesMap[product.productID] = true;
        }
        emit(GetFavSuccessState(products: products, favorites: favoritesMap));
      },
    );
  }

  void _mapChangeFavToState(ChangeFav event, Emitter<WishlistState> emit) {
    Map<String, bool> updatedFavorites = Map.from(state.favorites);

    if (state.favorites.containsKey(event.productID)) {
      updatedFavorites.remove(event.productID);
      emit(ToggleState(favorites: updatedFavorites, products: state.products));
      add(RemoveFromFav(productID: event.productID));
    } else {
      updatedFavorites[event.productID] = true;
      emit(ToggleState(favorites: updatedFavorites, products: state.products));
      add(AddToFav(productID: event.productID));
    }
  }
}
