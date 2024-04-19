part of 'all_products_bloc.dart';

sealed class AllProductsEvent extends Equatable {
  const AllProductsEvent();

  @override
  List<Object?> get props => [];
}

class GetAllProducts extends AllProductsEvent {
  final Map<String, dynamic>? queryParameters;

  const GetAllProducts({this.queryParameters});
  @override
  List<Object?> get props => [queryParameters];
}
