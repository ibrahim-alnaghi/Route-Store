part of 'search_bloc.dart';

class SearchStates extends Equatable {
  final RequestStates status;
  final String query;
  final String? errorMessage;
  final List<ProductEntity>? results;

  const SearchStates(
      {required this.status,
      required this.query,
      this.results,
      this.errorMessage});

  SearchStates copyWith({
    RequestStates? status,
    String? query,
    String? errorMessage,
    List<ProductEntity>? results,
  }) {
    return SearchStates(
      status: status ?? this.status,
      query: query ?? this.query,
      errorMessage: errorMessage ?? this.errorMessage,
      results: results ?? this.results,
    );
  }

  @override
  List<Object?> get props => [status, query, results, errorMessage];
}
