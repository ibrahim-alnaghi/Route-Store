import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/authentication/data/models/reset_password_request_body.dart';
import 'package:route_store/features/authentication/domain/repositories/authentication_domain_repo.dart';
import 'package:route_store/features/authentication/domain/usecases/rest_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthenticationDomainRepo extends Mock
    implements AuthenticationDomainRepo {}

void main() {
  late RestPasswordUseCase sut;
  late MockAuthenticationDomainRepo mockRepo;

  setUpAll(() {
    registerFallbackValue(ResetPasswordRequestBody(email: '', newPassword: ''));
  });

  setUp(() {
    mockRepo = MockAuthenticationDomainRepo();
    sut = RestPasswordUseCase(mockRepo);
  });

  group('RestPasswordUseCase', () {
    test('should delegate to repo.restPassword and return Right(String) on success',
        () async {
      // arrange
      when(() => mockRepo.restPassword(any()))
          .thenAnswer((_) async => const Right('Password reset successfully'));

      // act
      final result = await sut.call(
        ResetPasswordRequestBody(email: 'user@example.com', newPassword: 'dummy-new-pass-1'),
      );

      // assert
      expect(result, const Right('Password reset successfully'));
      verify(() => mockRepo.restPassword(any())).called(1);
    });

    test('should delegate to repo.restPassword and return Left(Failures) on failure',
        () async {
      // arrange
      final fakeFailure = ServerFailures('User not found');
      when(() => mockRepo.restPassword(any()))
          .thenAnswer((_) async => Left(fakeFailure));

      // act
      final result = await sut.call(
        ResetPasswordRequestBody(email: 'noone@example.com', newPassword: 'dummy-new-pass-2'),
      );

      // assert
      expect(result, Left(fakeFailure));
      verify(() => mockRepo.restPassword(any())).called(1);
    });

    test('should pass the exact email and newPassword to repo.restPassword',
        () async {
      // arrange
      when(() => mockRepo.restPassword(any()))
          .thenAnswer((_) async => const Right('ok'));

      // act
      await sut.call(
        ResetPasswordRequestBody(email: 'verify@example.com', newPassword: 'dummy-new-pass-verify'),
      );

      // assert
      final captured = verify(() => mockRepo.restPassword(captureAny())).captured;
      final capturedBody = captured.first as ResetPasswordRequestBody;
      expect(capturedBody.email, equals('verify@example.com'));
      expect(capturedBody.newPassword, equals('dummy-new-pass-verify'));
    });
  });
}
