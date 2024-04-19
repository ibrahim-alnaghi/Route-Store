import 'package:injectable/injectable.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/di/injection_container.dart';
import '../../../../authentication/domain/entities/user_entity.dart';
import '../../models/add_adress_request_body.dart';
import '../../models/adress_model.dart';

import '../../../../../core/api/api_service.dart';

import '../personalization_data_source.dart';

@LazySingleton(as: PersonalizationDataSource)
class PersonalizationRemoteData implements PersonalizationDataSource {
  final ApiService apiService;

  PersonalizationRemoteData(this.apiService);

  @override
  Future<List<AdressModel>> getAdresses() async {
    final data = await apiService.get(
      endPoint: EndPoints.addresses,
      headers: {"token": getIt<UserEntity>().userToken},
    );
    List<AdressModel> addresses = parseAddresses(data);
    return addresses;
  }

  List<AdressModel> parseAddresses(Map<String, dynamic> data) {
    List<AdressModel> addresses = [];
    for (var item in data['data']) {
      addresses.add(AdressModel.fromJson(item));
    }
    return addresses;
  }

  @override
  Future<void> addAdress(AddAdressRequestBody body) async {
    await apiService.post(
      endPoint: EndPoints.addresses,
      data: body.toJson(),
      headers: {"token": getIt<UserEntity>().userToken},
    );
  }
}
