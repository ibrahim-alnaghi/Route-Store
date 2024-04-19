part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class GetCategories extends HomeEvent {
  @override
  List<Object> get props => [];
}

class GetProducts extends HomeEvent {
  final Map<String, dynamic>? queryParameters;

  const GetProducts({this.queryParameters});
  @override
  List<Object?> get props => [queryParameters];
}

class UpdateBannrerIndex extends HomeEvent {
  final int index;

  const UpdateBannrerIndex({required this.index});
  @override
  List<Object> get props => [index];
}
