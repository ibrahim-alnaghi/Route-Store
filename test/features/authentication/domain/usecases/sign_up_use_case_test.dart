import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/authentication/data/models/signup_model/signup_request_body.dart';
import 'package:route_store/features/authentication/domain/entities/user_entity.dart';
import 'package:route_store/features/authentication/domain/repositories/authentication_domain_repo.dart';
import 'package:route_store/features/authentication/domain/usecases/sign_up_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthenticationDomainRepo extends Mock
    implements AuthenticationDomainRepo {}

void main() {
  late SignupUseCase sut;
  late MockAuthenticationDomainRepo mockRepo;

  setUpAll(() {
    registerFallbackValue(SignupRequestBody(
      name: '',
      email: '',
      password: '',
      rePassword: '',
      phone: '',
    ));
  });

  setUp(() {
    mockRepo = MockAuthenticationDomainRepo();
    sut = SignupUseCase(mockRepo);
  });

  const fakeUser = UserEntity(
    userToken: 'token456',
    userName: 'New User',
    userEmail: 'new@example.com',
  );

  final fakeFailure = ServerFailures('Email already exists');

  group('SignupUseCase', () {
    test('should delegate to repo.signup and return Right(UserEntity) on success',
        () async {
      // arrange
      when(() => mockRepo.signup(any()))
          .thenAnswer((_) async => const Right(fakeUser));

      // act
      final result = await sut.call(SignupRequestBody(
        name: 'New User',
        email: 'new@example.com',
        password: 'dummy-signup-pass-1',
        rePassword: 'dummy-signup-pass-1',
        phone: '01012345678',
      ));

      // assert
      expect(result, const Right(fakeUser));
      verify(() => mockRepo.signup(any())).called(1);
    });

    test('should delegate to repo.signup and return Left(Failures) on failure',
        () async {
      // arrange
      when(() => mockRepo.signup(any()))
          .thenAnswer((_) async => Left(fakeFailure));

      // act
      final result = await sut.call(SignupRequestBody(
        name: 'New User',
        email: 'new@example.com',
        password: 'dummy-signup-pass-1',
        rePassword: 'dummy-signup-pass-1',
        phone: '01012345678',
      ));

      // assert
      expect(result, Left(fakeFailure));
      verify(() => mockRepo.signup(any())).called(1);
    });

    test('should pass the exact param fields to repo.signup', () async {
      // arrange
      final requestBody = SignupRequestBody(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'dummy-signup-pass-3',
        rePassword: 'dummy-signup-pass-3',
        phone: '01098765432',
      );
      when(() => mockRepo.signup(any()))
          .thenAnswer((_) async => const Right(fakeUser));

      // act
      await sut.call(requestBody);

      // assert
      final captured = verify(() => mockRepo.signup(captureAny())).captured;
      final capturedBody = captured.first as SignupRequestBody;
      expect(capturedBody.name, equals('John Doe'));
      expect(capturedBody.email, equals('john@example.com'));
      expect(capturedBody.phone, equals('01098765432'));
    });
  });
}
