part of 'adresses_bloc.dart';

sealed class AdressesEvent extends Equatable {
  const AdressesEvent();

  @override
  List<Object> get props => [];
}

class GetAdresses extends AdressesEvent {}

class AddAdress extends AdressesEvent {}

class SelectedAddress extends AdressesEvent {
  final String selectedAddressID;

  const SelectedAddress({required this.selectedAddressID});
  @override
  List<Object> get props => [selectedAddressID];
}
