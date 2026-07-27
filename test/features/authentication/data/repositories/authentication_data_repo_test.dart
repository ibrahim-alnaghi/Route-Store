import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/authentication/data/datasources/authentication_data_sources.dart';
import 'package:route_store/features/authentication/data/models/login_model/login_model.dart';
import 'package:route_store/features/authentication/data/models/login_model/login_request_body.dart';
import 'package:route_store/features/authentication/data/models/reset_password_request_body.dart';
import 'package:route_store/features/authentication/data/models/signup_model/signup_model.dart';
import 'package:route_store/features/authentication/data/models/signup_model/signup_request_body.dart';
import 'package:route_store/features/authentication/data/repositories/authentication_data_repo.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthenticationDataSources extends Mock
    implements AuthenticationDataSources {}

void main() {
  late AuthenticationDataRepo sut;
  late MockAuthenticationDataSources mockDataSources;

  setUpAll(() {
    registerFallbackValue(LoginRequestBody(email: '', password: ''));
    registerFallbackValue(SignupRequestBody(
      name: '',
      email: '',
      password: '',
      rePassword: '',
      phone: '',
    ));
    registerFallbackValue(ResetPasswordRequestBody(email: '', newPassword: ''));
  });

  setUp(() {
    mockDataSources = MockAuthenticationDataSources();
    sut = AuthenticationDataRepo(mockDataSources);
  });

  DioException buildDioException(DioExceptionType type) => DioException(
        requestOptions: RequestOptions(path: ''),
        type: type,
      );

  group('AuthenticationDataRepo.login', () {
    final loginBody = LoginRequestBody(email: 'user@test.com', password: 'dummy-login-pass');
    final loginModel = LoginModel(token: 'tok', message: 'ok');

    test('should return Right(LoginModel) when datasource succeeds', () async {
      // arrange
      when(() => mockDataSources.login(any()))
          .thenAnswer((_) async => loginModel);

      // act
      final result = await sut.login(loginBody);

      // assert
      expect(result, isA<Right>());
      result.fold(
        (_) => fail('Expected Right'),
        (r) => expect(r, equals(loginModel)),
      );
    });

    test('should return Left(ServerFailures) with generic message when datasource throws Exception',
        () async {
      // arrange
      when(() => mockDataSources.login(any()))
          .thenThrow(Exception('Unexpected error'));

      // act
      final result = await sut.login(loginBody);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, contains('Exception: Unexpected error'));
        },
        (_) => fail('Expected Left'),
      );
    });

    test('should return Left(ServerFailures) with connection message when datasource throws DioException(connectionError)',
        () async {
      // arrange
      when(() => mockDataSources.login(any()))
          .thenThrow(buildDioException(DioExceptionType.connectionError));

      // act
      final result = await sut.login(loginBody);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('No Internet Connection'));
        },
        (_) => fail('Expected Left'),
      );
    });

    test('should return Left(ServerFailures) with timeout message when datasource throws DioException(connectionTimeout)',
        () async {
      // arrange
      when(() => mockDataSources.login(any()))
          .thenThrow(buildDioException(DioExceptionType.connectionTimeout));

      // act
      final result = await sut.login(loginBody);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('Connection timeout with api server'));
        },
        (_) => fail('Expected Left'),
      );
    });
  });

  group('AuthenticationDataRepo.signup', () {
    final signupBody = SignupRequestBody(
      name: 'New User',
      email: 'new@test.com',
      password: 'dummy-signup-pass',
      rePassword: 'dummy-signup-pass',
      phone: '0100000000',
    );
    final signupModel = SignupModel(token: 'tok2', message: 'created');

    test('should return Right(SignupModel) when datasource succeeds', () async {
      // arrange
      when(() => mockDataSources.signup(any()))
          .thenAnswer((_) async => signupModel);

      // act
      final result = await sut.signup(signupBody);

      // assert
      expect(result, isA<Right>());
      result.fold(
        (_) => fail('Expected Right'),
        (r) => expect(r, equals(signupModel)),
      );
    });

    test('should return Left(ServerFailures) with generic message when datasource throws Exception',
        () async {
      // arrange
      when(() => mockDataSources.signup(any()))
          .thenThrow(Exception('Server down'));

      // act
      final result = await sut.signup(signupBody);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, contains('Exception: Server down'));
        },
        (_) => fail('Expected Left'),
      );
    });

    test('should return Left(ServerFailures) with connection message when datasource throws DioException(connectionError)',
        () async {
      // arrange
      when(() => mockDataSources.signup(any()))
          .thenThrow(buildDioException(DioExceptionType.connectionError));

      // act
      final result = await sut.signup(signupBody);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('No Internet Connection'));
        },
        (_) => fail('Expected Left'),
      );
    });
  });

  group('AuthenticationDataRepo.sendCode', () {
    test('should return Right(String) when datasource succeeds', () async {
      // arrange
      when(() => mockDataSources.sendCode(any()))
          .thenAnswer((_) async => 'Code sent');

      // act
      final result = await sut.sendCode('user@test.com');

      // assert
      expect(result, const Right('Code sent'));
    });

    test('should return Left(ServerFailures) with generic message when datasource throws Exception',
        () async {
      // arrange
      when(() => mockDataSources.sendCode(any()))
          .thenThrow(Exception('Mail service error'));

      // act
      final result = await sut.sendCode('user@test.com');

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, contains('Exception: Mail service error'));
        },
        (_) => fail('Expected Left'),
      );
    });

    test('should return Left(ServerFailures) with connection message when datasource throws DioException(connectionError)',
        () async {
      // arrange
      when(() => mockDataSources.sendCode(any()))
          .thenThrow(buildDioException(DioExceptionType.connectionError));

      // act
      final result = await sut.sendCode('user@test.com');

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('No Internet Connection'));
        },
        (_) => fail('Expected Left'),
      );
    });
  });

  group('AuthenticationDataRepo.verifyCode', () {
    test('should return Right(String) when datasource succeeds', () async {
      // arrange
      when(() => mockDataSources.verifyCode(any()))
          .thenAnswer((_) async => 'Verified');

      // act
      final result = await sut.verifyCode('123456');

      // assert
      expect(result, const Right('Verified'));
    });

    test('should return Left(ServerFailures) with generic message when datasource throws Exception',
        () async {
      // arrange
      when(() => mockDataSources.verifyCode(any()))
          .thenThrow(Exception('OTP expired'));

      // act
      final result = await sut.verifyCode('000000');

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, contains('Exception: OTP expired'));
        },
        (_) => fail('Expected Left'),
      );
    });

    test('should return Left(ServerFailures) with cancel message when datasource throws DioException(cancel)',
        () async {
      // arrange
      when(() => mockDataSources.verifyCode(any()))
          .thenThrow(buildDioException(DioExceptionType.cancel));

      // act
      final result = await sut.verifyCode('123456');

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('Request to ApiServer was canceld'));
        },
        (_) => fail('Expected Left'),
      );
    });
  });

  group('AuthenticationDataRepo.restPassword', () {
    final resetBody = ResetPasswordRequestBody(
      email: 'user@test.com',
      newPassword: 'dummy-reset-pass',
    );

    test('should return Right(String) when datasource succeeds', () async {
      // arrange
      when(() => mockDataSources.restPassword(any()))
          .thenAnswer((_) async => 'Password reset');

      // act
      final result = await sut.restPassword(resetBody);

      // assert
      expect(result, const Right('Password reset'));
    });

    test('should return Left(ServerFailures) with generic message when datasource throws Exception',
        () async {
      // arrange
      when(() => mockDataSources.restPassword(any()))
          .thenThrow(Exception('Reset failed'));

      // act
      final result = await sut.restPassword(resetBody);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, contains('Exception: Reset failed'));
        },
        (_) => fail('Expected Left'),
      );
    });

    test('should return Left(ServerFailures) with receive timeout message when datasource throws DioException(receiveTimeout)',
        () async {
      // arrange
      when(() => mockDataSources.restPassword(any()))
          .thenThrow(buildDioException(DioExceptionType.receiveTimeout));

      // act
      final result = await sut.restPassword(resetBody);

      // assert
      expect(result, isA<Left>());
      result.fold(
        (l) {
          expect(l, isA<ServerFailures>());
          expect(l.message, equals('Receive timeout with ApiServer'));
        },
        (_) => fail('Expected Left'),
      );
    });
  });
}
