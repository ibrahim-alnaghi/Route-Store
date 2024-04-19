part of 'adresses_bloc.dart';

class AdressesStates extends Equatable {
  final RequestStates status;
  final String selectedAddress;
  final String? errorMessage;
  final List<AdressEntity>? adresses;

  const AdressesStates({
    required this.status,
    required this.selectedAddress,
    this.errorMessage,
    this.adresses,
  });

  AdressesStates copyWith(
      {RequestStates? status,
      String? selectedAddress,
      String? errorMessage,
      List<AdressEntity>? adresses}) {
    return AdressesStates(
      status: status ?? this.status,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      errorMessage: errorMessage ?? this.errorMessage,
      adresses: adresses ?? this.adresses,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, adresses, selectedAddress];
}
