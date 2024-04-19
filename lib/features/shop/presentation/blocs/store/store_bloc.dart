import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums.dart';
import '../../../domain/entities/category_entity/category_entity.dart';
import '../../../domain/entities/product_entity/product_entity.dart';
import '../../../domain/usecases/get_categories_use_case.dart';
import '../../../domain/usecases/get_products_use_case.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreStates> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductsUseCase _getProductsUseCase;
  StoreBloc(
      {required GetCategoriesUseCase getCategoriesUseCase,
      required GetProductsUseCase getProductsUseCase})
      : _getCategoriesUseCase = getCategoriesUseCase,
        _getProductsUseCase = getProductsUseCase,
        super(const StoreStates(status: RequestStates.initial)) {
    on<GetStoreCategories>((event, emit) async {
      await _getCategories(emit);
    });
    on<GeStoretProducts>((event, emit) async {
      await _getProducts(emit, queryParameters: event.queryParameters);
    });
  }
  Future<void> _getCategories(Emitter<StoreStates> emit) async {
    emit(state.copyWith(status: RequestStates.loading));

    final result = await _getCategoriesUseCase.call();

    result.fold(
      (l) {
        emit(state.copyWith(
            status: RequestStates.failure, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStates.success, categories: r));
      },
    );
  }

  Future<void> _getProducts(Emitter<StoreStates> emit,
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
        emit(state.copyWith(
            status: RequestStates.success,
            topProducts: r.isNotEmpty ? r.sublist(4, 7) : [],
            products: r.isNotEmpty ? r.sublist(0, 4) : []));
      },
    );
  }
}
