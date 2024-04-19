import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/enums.dart';
import '../../../../../core/constants/keys_constants.dart';
import '../../../../../core/local_storage/cache_helper.dart';
import '../../../data/models/add_adress_request_body.dart';
import '../../../domain/entities/adress_entity.dart';
import '../../../domain/usecases/add_adress_use_case.dart';
import '../../../domain/usecases/get_adresses_use_case.dart';

part 'adresses_event.dart';
part 'adresses_state.dart';

class AdressesBloc extends Bloc<AdressesEvent, AdressesStates> {
  final GetAdressesUseCase _getAdressesUseCase;
  final AddAdressUseCase _addAdressUseCase;
  final name = TextEditingController();
  final phone = TextEditingController();
  final street = TextEditingController();
  final area = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AdressesBloc(
      {required GetAdressesUseCase getAdressesUseCase,
      required AddAdressUseCase addAdressUseCase})
      : _getAdressesUseCase = getAdressesUseCase,
        _addAdressUseCase = addAdressUseCase,
        super(AdressesStates(
            status: RequestStates.initial,
            selectedAddress: CacheHelper.getData(adressIDKey) ?? '')) {
    on<GetAdresses>((event, emit) async {
      await _getAdresses(emit);
    });
    on<SelectedAddress>((event, emit) async {
      await _selectedAddress(event.selectedAddressID, emit);
    });
    on<AddAdress>((event, emit) async {
      await _addAdress(emit);
    });
  }

  Future<void> _getAdresses(Emitter<AdressesStates> emit) async {
    emit(state.copyWith(status: RequestStates.loading));

    final result = await _getAdressesUseCase.call();

    result.fold(
      (l) {
        emit(state.copyWith(
            status: RequestStates.failure, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStates.success, adresses: r));
      },
    );
  }

  Future<void> _addAdress(Emitter<AdressesStates> emit) async {
    emit(state.copyWith(status: RequestStates.loading));

    final result = await _addAdressUseCase.call(
      AddAdressRequestBody(
          name: name.text.trim(),
          phone: phone.text.trim(),
          details:
              '${street.text.trim()}, ${area.text.trim()}, ${postalCode.text.trim()}, ${city.text.trim()}',
          city: city.text.trim()),
    );

    result.fold(
      (l) {
        emit(state.copyWith(
            status: RequestStates.failure, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStates.success));
      },
    );
  }

  Future<void> _selectedAddress(
      String selectedAddressID, Emitter<AdressesStates> emit) async {
    if (await CacheHelper.getData(adressIDKey) == selectedAddressID) {
      await CacheHelper.saveData(key: adressIDKey, value: '');
      emit(state.copyWith(
          selectedAddress: await CacheHelper.getData(adressIDKey)));
    } else {
      await CacheHelper.saveData(key: adressIDKey, value: selectedAddressID);
      emit(state.copyWith(
          selectedAddress: await CacheHelper.getData(adressIDKey)));
    }
  }
}
