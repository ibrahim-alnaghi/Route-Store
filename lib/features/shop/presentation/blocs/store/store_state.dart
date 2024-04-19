part of 'store_bloc.dart';

class StoreStates extends Equatable {
  final RequestStates status;
  final String? errorMessage;
  final List<CategoryEntity>? categories;
  final List<ProductEntity>? products;
  final List<ProductEntity>? topProducts;
  const StoreStates({
    required this.status,
    this.errorMessage,
    this.categories,
    this.products,
    this.topProducts,
  });

  StoreStates copyWith({
    RequestStates? status,
    String? errorMessage,
    List<CategoryEntity>? categories,
    List<ProductEntity>? products,
    List<ProductEntity>? topProducts,
  }) {
    return StoreStates(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      topProducts: topProducts ?? this.topProducts,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, categories, products];
}
