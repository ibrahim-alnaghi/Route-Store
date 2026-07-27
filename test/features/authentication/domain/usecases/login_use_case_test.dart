import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/authentication/data/models/login_model/login_request_body.dart';
import 'package:route_store/features/authentication/domain/entities/user_entity.dart';
import 'package:route_store/features/authentication/domain/repositories/authentication_domain_repo.dart';
import 'package:route_store/features/authentication/domain/usecases/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthenticationDomainRepo extends Mock
    implements AuthenticationDomainRepo {}

void main() {
  late LoginUseCase sut;
  late MockAuthenticationDomainRepo mockRepo;

  setUpAll(() {
    registerFallbackValue(LoginRequestBody(email: '', password: ''));
  });

  setUp(() {
    mockRepo = MockAuthenticationDomainRepo();
    sut = LoginUseCase(mockRepo);
  });

  const fakeUser = UserEntity(
    userToken: 'token123',
    userName: 'Test User',
    userEmail: 'test@example.com',
  );

  final fakeFailure = ServerFailures('Unauthorized');

  group('LoginUseCase', () {
    test('should delegate to repo.login and return Right(UserEntity) on success',
        () async {
      // arrange
      when(() => mockRepo.login(any()))
          .thenAnswer((_) async => const Right(fakeUser));

      // act
      final result = await sut.call(LoginRequestBody(email: 'test@example.com', password: 'dummy-login-pass'));

      // assert
      expect(result, const Right(fakeUser));
      verify(() => mockRepo.login(any())).called(1);
    });

    test('should delegate to repo.login and return Left(Failures) on failure',
        () async {
      // arrange
      when(() => mockRepo.login(any()))
          .thenAnswer((_) async => Left(fakeFailure));

      // act
      final result = await sut.call(LoginRequestBody(email: 'test@example.com', password: 'dummy-login-pass'));

      // assert
      expect(result, Left(fakeFailure));
      verify(() => mockRepo.login(any())).called(1);
    });

    test('should pass the exact param to repo.login', () async {
      // arrange
      final requestBody = LoginRequestBody(email: 'user@test.com', password: 'dummy-captured-pass');
      when(() => mockRepo.login(any()))
          .thenAnswer((_) async => const Right(fakeUser));

      // act
      await sut.call(requestBody);

      // assert
      final captured = verify(() => mockRepo.login(captureAny())).captured;
      final capturedBody = captured.first as LoginRequestBody;
      expect(capturedBody.email, equals('user@test.com'));
      expect(capturedBody.password, equals('dummy-captured-pass'));
    });
  });
}
