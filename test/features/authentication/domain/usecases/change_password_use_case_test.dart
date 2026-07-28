import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/authentication/data/models/change_password_request_body.dart';
import 'package:route_store/features/authentication/domain/repositories/authentication_domain_repo.dart';
import 'package:route_store/features/authentication/domain/usecases/change_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthenticationDomainRepo extends Mock
    implements AuthenticationDomainRepo {}

void main() {
  late ChangePasswordUseCase sut;
  late MockAuthenticationDomainRepo mockRepo;

  setUpAll(() {
    registerFallbackValue(ChangePasswordRequestBody(
        currentPassword: '', password: '', rePassword: ''));
  });

  setUp(() {
    mockRepo = MockAuthenticationDomainRepo();
    sut = ChangePasswordUseCase(mockRepo);
  });

  final fakeFailure = ServerFailures('Change password failed');

  group('ChangePasswordUseCase', () {
    test('should delegate to repo.changePassword and return Right(void) on success',
        () async {
      // arrange
      when(() => mockRepo.changePassword(any()))
          .thenAnswer((_) async => const Right(null));

      // act
      final result = await sut.call(ChangePasswordRequestBody(
          currentPassword: 'dummy-current-pass',
          password: 'dummy-new-pass',
          rePassword: 'dummy-new-pass'));

      // assert
      expect(result, const Right(null));
      verify(() => mockRepo.changePassword(any())).called(1);
    });

    test(
        'should delegate to repo.changePassword and return Left(Failures) on failure',
        () async {
      // arrange
      when(() => mockRepo.changePassword(any()))
          .thenAnswer((_) async => Left(fakeFailure));

      // act
      final result = await sut.call(ChangePasswordRequestBody(
          currentPassword: 'dummy-current-pass',
          password: 'dummy-new-pass',
          rePassword: 'dummy-new-pass'));

      // assert
      expect(result, Left(fakeFailure));
      verify(() => mockRepo.changePassword(any())).called(1);
    });

    test('should pass the exact param to repo.changePassword', () async {
      // arrange
      final requestBody = ChangePasswordRequestBody(
          currentPassword: 'dummy-old-pass',
          password: 'dummy-brand-new-pass',
          rePassword: 'dummy-brand-new-pass');
      when(() => mockRepo.changePassword(any()))
          .thenAnswer((_) async => const Right(null));

      // act
      await sut.call(requestBody);

      // assert
      final captured =
          verify(() => mockRepo.changePassword(captureAny())).captured;
      final capturedBody = captured.first as ChangePasswordRequestBody;
      expect(capturedBody.currentPassword, equals('dummy-old-pass'));
      expect(capturedBody.password, equals('dummy-brand-new-pass'));
      expect(capturedBody.rePassword, equals('dummy-brand-new-pass'));
    });
  });
}
