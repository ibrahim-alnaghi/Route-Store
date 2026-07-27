import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/authentication/domain/repositories/authentication_domain_repo.dart';
import 'package:route_store/features/authentication/domain/usecases/verify_code_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthenticationDomainRepo extends Mock
    implements AuthenticationDomainRepo {}

void main() {
  late VerifyCodeUseCase sut;
  late MockAuthenticationDomainRepo mockRepo;

  setUp(() {
    mockRepo = MockAuthenticationDomainRepo();
    sut = VerifyCodeUseCase(mockRepo);
  });

  group('VerifyCodeUseCase', () {
    test('should delegate to repo.verifyCode and return Right(String) on success',
        () async {
      // arrange
      when(() => mockRepo.verifyCode(any()))
          .thenAnswer((_) async => const Right('Verified'));

      // act
      final result = await sut.call('123456');

      // assert
      expect(result, const Right('Verified'));
      verify(() => mockRepo.verifyCode('123456')).called(1);
    });

    test('should delegate to repo.verifyCode and return Left(Failures) on failure',
        () async {
      // arrange
      final fakeFailure = ServerFailures('Invalid OTP code');
      when(() => mockRepo.verifyCode(any()))
          .thenAnswer((_) async => Left(fakeFailure));

      // act
      final result = await sut.call('000000');

      // assert
      expect(result, Left(fakeFailure));
      verify(() => mockRepo.verifyCode('000000')).called(1);
    });

    test('should pass the otp string exactly to repo.verifyCode', () async {
      // arrange
      when(() => mockRepo.verifyCode(any()))
          .thenAnswer((_) async => const Right('ok'));

      // act
      await sut.call('987654');

      // assert
      final captured = verify(() => mockRepo.verifyCode(captureAny())).captured;
      expect(captured.first, equals('987654'));
    });
  });
}
