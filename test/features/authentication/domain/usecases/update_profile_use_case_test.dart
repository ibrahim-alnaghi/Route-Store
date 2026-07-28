import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/authentication/data/models/update_profile_request_body.dart';
import 'package:route_store/features/authentication/domain/entities/user_entity.dart';
import 'package:route_store/features/authentication/domain/repositories/authentication_domain_repo.dart';
import 'package:route_store/features/authentication/domain/usecases/update_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthenticationDomainRepo extends Mock
    implements AuthenticationDomainRepo {}

void main() {
  late UpdateProfileUseCase sut;
  late MockAuthenticationDomainRepo mockRepo;

  setUpAll(() {
    registerFallbackValue(UpdateProfileRequestBody(name: '', email: ''));
  });

  setUp(() {
    mockRepo = MockAuthenticationDomainRepo();
    sut = UpdateProfileUseCase(mockRepo);
  });

  const fakeUser = UserEntity(
    userToken: 'token123',
    userName: 'Test User',
    userEmail: 'test@example.com',
  );

  final fakeFailure = ServerFailures('Update failed');

  group('UpdateProfileUseCase', () {
    test(
        'should delegate to repo.updateProfile and return Right(UserEntity) on success',
        () async {
      // arrange
      when(() => mockRepo.updateProfile(any()))
          .thenAnswer((_) async => const Right(fakeUser));

      // act
      final result = await sut.call(UpdateProfileRequestBody(
          name: 'Test User', email: 'test@example.com'));

      // assert
      expect(result, const Right(fakeUser));
      verify(() => mockRepo.updateProfile(any())).called(1);
    });

    test(
        'should delegate to repo.updateProfile and return Left(Failures) on failure',
        () async {
      // arrange
      when(() => mockRepo.updateProfile(any()))
          .thenAnswer((_) async => Left(fakeFailure));

      // act
      final result = await sut.call(UpdateProfileRequestBody(
          name: 'Test User', email: 'test@example.com'));

      // assert
      expect(result, Left(fakeFailure));
      verify(() => mockRepo.updateProfile(any())).called(1);
    });

    test('should pass the exact param to repo.updateProfile', () async {
      // arrange
      final requestBody =
          UpdateProfileRequestBody(name: 'Jane Doe', email: 'jane@test.com');
      when(() => mockRepo.updateProfile(any()))
          .thenAnswer((_) async => const Right(fakeUser));

      // act
      await sut.call(requestBody);

      // assert
      final captured =
          verify(() => mockRepo.updateProfile(captureAny())).captured;
      final capturedBody = captured.first as UpdateProfileRequestBody;
      expect(capturedBody.name, equals('Jane Doe'));
      expect(capturedBody.email, equals('jane@test.com'));
    });
  });
}
