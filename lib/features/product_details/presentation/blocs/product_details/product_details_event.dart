part of 'product_details_bloc.dart';

sealed class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class ImageSelected extends ProductDetailsEvent {
  final String selectedImage;

  const ImageSelected(this.selectedImage);

  @override
  List<Object> get props => [selectedImage];
}
