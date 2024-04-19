part of 'product_details_bloc.dart';

class ProductDetailsStates extends Equatable {
  final String? selectedImage;

  const ProductDetailsStates({this.selectedImage});

  ProductDetailsStates copyWith({String? selectedImage}) {
    return ProductDetailsStates(
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }

  @override
  List<Object?> get props => [selectedImage];
}
