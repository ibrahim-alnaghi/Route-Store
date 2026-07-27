import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/personalization/data/datasources/personalization_data_source.dart';
import 'package:route_store/features/personalization/data/models/add_adress_request_body.dart';
import 'package:route_store/features/personalization/data/models/adress_model.dart';
import 'package:route_store/features/personalization/data/repositories/personalization_data_repo.dart';

class MockPersonalizationDataSource extends Mock
    implements PersonalizationDataSource {}

class FakeAddAdressRequestBody extends Fake implements AddAdressRequestBody {}

void main() {
  late PersonalizationDataRepo sut;
  late MockPersonalizationDataSource mockDataSource;

  setUpAll(() {
    registerFallbackValue(FakeAddAdressRequestBody());
  });

  setUp(() {
    mockDataSource = MockPersonalizationDataSource();
    sut = PersonalizationDataRepo(mockDataSource);
  });

  DioException buildDioException(DioExceptionType type, {Response? response}) =>
      DioException(
        requestOptions: RequestOptions(path: ''),
        type: type,
        response: response,
      );

  const fakeAddress = AdressModel(
    id: 'addr-1',
    name: 'Home',
    details: 'Street 1',
    phone: '01000000000',
    city: 'Cairo',
  );

  final requestBody = AddAdressRequestBody(
    name: 'Home',
    details: 'Street 1',
    phone: '01000000000',
    city: 'Cairo',
  );

  group('PersonalizationDataRepo.getAdresses', () {
    test('should return Right(List<AdressEntity>) when the data source call succeeds',
        () async {
      // arrange
      when(() => mockDataSource.getAdresses())
          .thenAnswer((_) async => [fakeAddress]);

      // act
      final result = await sut.getAdresses();

      // assert
      expect(result, isA<Right>());
      result.fold(
        (l) => fail('expected Right'),
        (r) => expect(r, equals([fakeAddress])),
      );
    });

    test('should return Left(ServerFailures) with generic message when data source throws Exception',
        () async {
      // arrange
      when(() => mockDataSource.getAdresses())
          .thenThrow(Exception('unexpected'));

      // act
      final result = await sut.getAdresses();

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, contains('Exception: unexpected'));
        },
        (_) => fail('expected Left'),
      );
    });

    test('should return Left(ServerFailures) with connection message when data source throws DioException(connectionError)',
        () async {
      // arrange
      when(() => mockDataSource.getAdresses())
          .thenThrow(buildDioException(DioExceptionType.connectionError));

      // act
      final result = await sut.getAdresses();

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('No Internet Connection'));
        },
        (_) => fail('expected Left'),
      );
    });
  });

  group('PersonalizationDataRepo.addAdress', () {
    test('should return Right(void) when the data source call succeeds',
        () async {
      // arrange
      when(() => mockDataSource.addAdress(any())).thenAnswer((_) async {});

      // act
      final result = await sut.addAdress(requestBody);

      // assert
      expect(result, isA<Right>());
    });

    test('should call the data source with the given request body', () async {
      // arrange
      when(() => mockDataSource.addAdress(any())).thenAnswer((_) async {});

      // act
      await sut.addAdress(requestBody);

      // assert
      verify(() => mockDataSource.addAdress(requestBody)).called(1);
    });

    test('should return Left(ServerFailures) with generic message when data source throws Exception',
        () async {
      // arrange
      when(() => mockDataSource.addAdress(any()))
          .thenThrow(Exception('unexpected'));

      // act
      final result = await sut.addAdress(requestBody);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, contains('Exception: unexpected'));
        },
        (_) => fail('expected Left'),
      );
    });

    test('should return Left(ServerFailures) with timeout message when data source throws DioException(connectionTimeout)',
        () async {
      // arrange
      when(() => mockDataSource.addAdress(any()))
          .thenThrow(buildDioException(DioExceptionType.connectionTimeout));

      // act
      final result = await sut.addAdress(requestBody);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('Connection timeout with api server'));
        },
        (_) => fail('expected Left'),
      );
    });
  });

  group('PersonalizationDataRepo.removeAdress', () {
    const addressId = 'addr-1';

    test('should return Right(void) when the data source call succeeds',
        () async {
      // arrange
      when(() => mockDataSource.removeAdress(any()))
          .thenAnswer((_) async {});

      // act
      final result = await sut.removeAdress(addressId);

      // assert
      expect(result, isA<Right>());
    });

    test('should call the data source with the given addressId', () async {
      // arrange
      when(() => mockDataSource.removeAdress(any()))
          .thenAnswer((_) async {});

      // act
      await sut.removeAdress(addressId);

      // assert
      verify(() => mockDataSource.removeAdress(addressId)).called(1);
    });

    test('should return Left(ServerFailures) with generic message when data source throws Exception',
        () async {
      // arrange
      when(() => mockDataSource.removeAdress(any()))
          .thenThrow(Exception('unexpected'));

      // act
      final result = await sut.removeAdress(addressId);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, contains('Exception: unexpected'));
        },
        (_) => fail('expected Left'),
      );
    });

    test('should return Left(ServerFailures) with connection message when data source throws DioException(connectionError)',
        () async {
      // arrange
      when(() => mockDataSource.removeAdress(any()))
          .thenThrow(buildDioException(DioExceptionType.connectionError));

      // act
      final result = await sut.removeAdress(addressId);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('No Internet Connection'));
        },
        (_) => fail('expected Left'),
      );
    });

    test('should return Left(ServerFailures) with cancel message when data source throws DioException(cancel)',
        () async {
      // arrange
      when(() => mockDataSource.removeAdress(any()))
          .thenThrow(buildDioException(DioExceptionType.cancel));

      // act
      final result = await sut.removeAdress(addressId);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('Request to ApiServer was canceld'));
        },
        (_) => fail('expected Left'),
      );
    });

    test('should return Left(ServerFailures) mapped from the response body when data source throws DioException(badResponse) with a 404',
        () async {
      // arrange
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 404,
      );
      when(() => mockDataSource.removeAdress(any())).thenThrow(
          buildDioException(DioExceptionType.badResponse,
              response: response));

      // act
      final result = await sut.removeAdress(addressId);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('Your request was not found'));
        },
        (_) => fail('expected Left'),
      );
    });
  });
}
