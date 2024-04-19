import '../models/add_adress_request_body.dart';
import '../models/adress_model.dart';

abstract class PersonalizationDataSource {
  Future<List<AdressModel>> getAdresses();
  Future<void> addAdress(AddAdressRequestBody body);
}
