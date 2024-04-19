part of 'all_products_bloc.dart';

class AllProductsStates extends Equatable {
  final RequestStates status;
  final String? errorMessage;

  final List<ProductEntity>? products;

  const AllProductsStates(
      {required this.status, this.products, this.errorMessage});

  AllProductsStates copyWith({
    RequestStates? status,
    String? errorMessage,
    List<ProductEntity>? products,
  }) {
    return AllProductsStates(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage];
}
