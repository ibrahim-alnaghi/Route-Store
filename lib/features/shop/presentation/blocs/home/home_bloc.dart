import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums.dart';
import '../../../domain/entities/brand_entity/brand_entity.dart';
import '../../../domain/entities/product_entity/product_entity.dart';
import '../../../domain/usecases/get_brands_use_case.dart';
import '../../../domain/usecases/get_products_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeStates> {
  final GetBrandsUseCase _getBrandsUseCase;
  final GetProductsUseCase _getProductsUseCase;
  HomeBloc(
      {required GetBrandsUseCase getBrandsUseCase,
      required GetProductsUseCase getProductsUseCase})
      : _getBrandsUseCase = getBrandsUseCase,
        _getProductsUseCase = getProductsUseCase,
        super(const HomeStates(status: RequestStates.initial)) {
    on<GetCategories>((event, emit) async {
      await _getCategories(emit);
    });
    on<UpdateBannrerIndex>((event, emit) async {
      emit(state.copyWith(bannrerIndex: event.index));
    });
    on<GetProducts>((event, emit) async {
      await _getProducts(emit, queryParameters: event.queryParameters);
    });
  }
  Future<void> _getCategories(Emitter<HomeStates> emit) async {
    emit(state.copyWith(status: RequestStates.loading));

    final result = await _getBrandsUseCase.call();

    result.fold(
      (l) {
        emit(state.copyWith(
            status: RequestStates.failure, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStates.success, brands: r));
      },
    );
  }

  Future<void> _getProducts(Emitter<HomeStates> emit,
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
