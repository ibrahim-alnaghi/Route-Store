import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums.dart';
import '../../../domain/entities/product_entity/product_entity.dart';
import '../../../domain/usecases/get_products_use_case.dart';

part 'all_products_event.dart';
part 'all_products_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsStates> {
  final GetProductsUseCase _getProductsUseCase;

  AllProductsBloc({required GetProductsUseCase getProductsUseCase})
      : _getProductsUseCase = getProductsUseCase,
        super(const AllProductsStates(status: RequestStates.initial)) {
    on<GetAllProducts>((event, emit) async {
      await _getAllProducts(emit, queryParameters: event.queryParameters);
    });
  }

  Future<void> _getAllProducts(Emitter<AllProductsStates> emit,
      {Map<String, dynamic>? queryParameters}) async {
    emit(state.copyWith(status: RequestStates.loading));

    final result =
        await _getProductsUseCase.call(queryParameters: queryParameters);

    result.fold(
      (l) {
        emit(state.copyWith(
            status: RequestStates.failure, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStates.success, products: r));
      },
    );
  }
}
