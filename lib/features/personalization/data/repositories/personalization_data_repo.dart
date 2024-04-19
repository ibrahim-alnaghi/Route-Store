import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/failures/server_failures.dart';
import '../datasources/personalization_data_source.dart';
import '../models/add_adress_request_body.dart';
import '../models/adress_model.dart';
import '../../domain/repositories/personalization_domain_repo.dart';

@LazySingleton(as: PersonalizationDomainRepo)
class PersonalizationDataRepo implements PersonalizationDomainRepo {
  final PersonalizationDataSource personalizationDataSource;

  PersonalizationDataRepo(this.personalizationDataSource);

  @override
  Future<Either<Failures, List<AdressModel>>> getAdresses() async {
    try {
      List<AdressModel> adresses =
          await personalizationDataSource.getAdresses();
      return Right(adresses);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> addAdress(AddAdressRequestBody body) async {
    try {
      return Right(await personalizationDataSource.addAdress(body));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }
}
