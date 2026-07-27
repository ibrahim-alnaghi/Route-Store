import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/personalization/domain/repositories/personalization_domain_repo.dart';
import 'package:route_store/features/personalization/domain/usecases/remove_adress_use_case.dart';

class MockPersonalizationDomainRepo extends Mock
    implements PersonalizationDomainRepo {}

void main() {
  late RemoveAdressUseCase sut;
  late MockPersonalizationDomainRepo mockRepo;

  setUp(() {
    mockRepo = MockPersonalizationDomainRepo();
    sut = RemoveAdressUseCase(mockRepo);
  });

  const addressId = 'addr-1';

  test('delegates to repo.removeAdress with the exact addressId on success',
      () async {
    when(() => mockRepo.removeAdress(any()))
        .thenAnswer((_) async => const Right(null));

    final result = await sut.call(addressId);

    expect(result, const Right(null));
    verify(() => mockRepo.removeAdress(addressId)).called(1);
  });

  test('propagates a Failure from the repo when removing the address fails',
      () async {
    final fakeFailure = ServerFailures('Could not remove address');
    when(() => mockRepo.removeAdress(any()))
        .thenAnswer((_) async => Left(fakeFailure));

    final result = await sut.call(addressId);

    expect(result, Left(fakeFailure));
  });
}
