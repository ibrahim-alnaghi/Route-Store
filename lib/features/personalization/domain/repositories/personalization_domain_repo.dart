import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../data/models/add_adress_request_body.dart';
import '../entities/adress_entity.dart';

abstract class PersonalizationDomainRepo {
  Future<Either<Failures, List<AdressEntity>>> getAdresses();
  Future<Either<Failures, void>> addAdress(AddAdressRequestBody body);
}
