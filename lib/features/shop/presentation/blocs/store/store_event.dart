part of 'store_bloc.dart';

sealed class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object?> get props => [];
}

class GetStoreCategories extends StoreEvent {
  @override
  List<Object> get props => [];
}

class GeStoretProducts extends StoreEvent {
  final Map<String, dynamic>? queryParameters;

  const GeStoretProducts({this.queryParameters});
  @override
  List<Object?> get props => [queryParameters];
}
