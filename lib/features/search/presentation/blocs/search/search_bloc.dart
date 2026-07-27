import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../shop/domain/entities/product_entity/product_entity.dart';
import '../../../domain/usecases/search_products_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchStates> {
  final SearchProductsUseCase _searchProductsUseCase;
  Timer? _debounce;

  SearchBloc({required SearchProductsUseCase searchProductsUseCase})
      : _searchProductsUseCase = searchProductsUseCase,
        super(const SearchStates(status: RequestStates.initial, query: '')) {
    on<SearchQueryChanged>(_onQueryChanged);
    on<SearchDebounceFired>(_onDebounceFired);
  }

  void _onQueryChanged(SearchQueryChanged event, Emitter<SearchStates> emit) {
    _debounce?.cancel();
    emit(state.copyWith(query: event.query));

    if (event.query.trim().isEmpty) {
      emit(state.copyWith(status: RequestStates.initial, results: []));
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500),
        () => add(SearchDebounceFired(event.query)));
  }

  Future<void> _onDebounceFired(
      SearchDebounceFired event, Emitter<SearchStates> emit) async {
    emit(state.copyWith(status: RequestStates.loading));

    final result = await _searchProductsUseCase.call(event.query);

    // Discard stale responses: if the user has typed a newer query since
    // this request started, `state.query` has already moved on.
    if (event.query != state.query) return;

    result.fold(
      (l) => emit(
          state.copyWith(status: RequestStates.failure, errorMessage: l.message)),
      (r) => emit(state.copyWith(status: RequestStates.success, results: r)),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
