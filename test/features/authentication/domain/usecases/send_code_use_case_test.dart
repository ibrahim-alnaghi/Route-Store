import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/authentication/domain/repositories/authentication_domain_repo.dart';
import 'package:route_store/features/authentication/domain/usecases/send_code_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthenticationDomainRepo extends Mock
    implements AuthenticationDomainRepo {}

void main() {
  late SendCodeUseCase sut;
  late MockAuthenticationDomainRepo mockRepo;

  setUp(() {
    mockRepo = MockAuthenticationDomainRepo();
    sut = SendCodeUseCase(mockRepo);
  });

  group('SendCodeUseCase', () {
    test('should delegate to repo.sendCode and return Right(String) on success',
        () async {
      // arrange
      when(() => mockRepo.sendCode(any()))
          .thenAnswer((_) async => const Right('Code sent successfully'));

      // act
      final result = await sut.call('user@example.com');

      // assert
      expect(result, const Right('Code sent successfully'));
      verify(() => mockRepo.sendCode('user@example.com')).called(1);
    });

    test('should delegate to repo.sendCode and return Left(Failures) on failure',
        () async {
      // arrange
      final fakeFailure = ServerFailures('Email not found');
      when(() => mockRepo.sendCode(any()))
          .thenAnswer((_) async => Left(fakeFailure));

      // act
      final result = await sut.call('unknown@example.com');

      // assert
      expect(result, Left(fakeFailure));
      verify(() => mockRepo.sendCode('unknown@example.com')).called(1);
    });

    test('should pass the email string exactly to repo.sendCode', () async {
      // arrange
      when(() => mockRepo.sendCode(any()))
          .thenAnswer((_) async => const Right('ok'));

      // act
      await sut.call('exact@email.com');

      // assert
      final captured = verify(() => mockRepo.sendCode(captureAny())).captured;
      expect(captured.first, equals('exact@email.com'));
    });
  });
}
