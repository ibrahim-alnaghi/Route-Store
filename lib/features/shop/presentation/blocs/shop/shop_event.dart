part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();
}

class SelectNavigationEvent extends ShopEvent {
  final int selectedIndex;

  const SelectNavigationEvent(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}
