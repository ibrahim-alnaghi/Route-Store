part of 'shop_bloc.dart';

class ShopStates extends Equatable {
  final int selectedIndex;

  const ShopStates({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}
