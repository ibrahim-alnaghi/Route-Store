import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsStates> {
  ProductDetailsBloc() : super(const ProductDetailsStates()) {
    on<ImageSelected>((event, emit) {
      emit(state.copyWith(selectedImage: event.selectedImage));
    });
  }
}
