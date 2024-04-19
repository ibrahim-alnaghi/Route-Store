part of 'home_bloc.dart';

class HomeStates extends Equatable {
  final RequestStates status;
  final String? errorMessage;
  final List<BrandEntity>? brands;
  final List<ProductEntity>? products;
  final int bannrerIndex;

  const HomeStates(
      {required this.status,
      this.errorMessage,
      this.brands,
      this.products,
      this.bannrerIndex = 0});

  HomeStates copyWith(
      {RequestStates? status,
      String? errorMessage,
      List<BrandEntity>? brands,
      List<ProductEntity>? products,
      final int? bannrerIndex}) {
    return HomeStates(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      brands: brands ?? this.brands,
      products: products ?? this.products,
      bannrerIndex: bannrerIndex ?? this.bannrerIndex,
    );
  }

  @override
  List<Object?> get props =>
      [status, errorMessage, brands, products, bannrerIndex];
}
