import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/constants/enums.dart';
import 'package:route_store/core/constants/keys_constants.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/core/local_storage/cache_helper.dart';
import 'package:route_store/features/personalization/domain/entities/adress_entity.dart';
import 'package:route_store/features/personalization/domain/usecases/add_adress_use_case.dart';
import 'package:route_store/features/personalization/domain/usecases/get_adresses_use_case.dart';
import 'package:route_store/features/personalization/presentation/bloc/adresses/adresses_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockGetAdressesUseCase extends Mock implements GetAdressesUseCase {}

class MockAddAdressUseCase extends Mock implements AddAdressUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGetAdressesUseCase mockGetAdressesUseCase;
  late MockAddAdressUseCase mockAddAdressUseCase;

  AdressesBloc buildBloc() => AdressesBloc(
        getAdressesUseCase: mockGetAdressesUseCase,
        addAdressUseCase: mockAddAdressUseCase,
      );

  setUp(() {
    mockGetAdressesUseCase = MockGetAdressesUseCase();
    mockAddAdressUseCase = MockAddAdressUseCase();
  });

  const fakeAddress = AdressEntity(
    adressID: 'addr-1',
    adressName: 'Home',
    adressDetails: 'Street 1',
    adressPhone: '01000000000',
    adressCity: 'Cairo',
  );
  final fakeFailure = ServerFailures('Could not fetch addresses');

  group('AdressesBloc - GetAdresses baseline', () {
    blocTest<AdressesBloc, AdressesStates>(
      'emits [loading, success] with the fetched addresses when there is no cached selection',
      setUp: () async {
        SharedPreferences.setMockInitialValues({});
        await CacheHelper.init();
      },
      build: () {
        when(() => mockGetAdressesUseCase.call())
            .thenAnswer((_) async => const Right([fakeAddress]));
        return buildBloc();
      },
      act: (bloc) => bloc.add(GetAdresses()),
      expect: () => [
        const AdressesStates(
            status: RequestStates.loading, selectedAddress: ''),
        const AdressesStates(
            status: RequestStates.success,
            selectedAddress: '',
            adresses: [fakeAddress]),
      ],
    );

    blocTest<AdressesBloc, AdressesStates>(
      'emits [loading, failure] with errorMessage when fetching addresses fails',
      setUp: () async {
        SharedPreferences.setMockInitialValues({});
        await CacheHelper.init();
      },
      build: () {
        when(() => mockGetAdressesUseCase.call())
            .thenAnswer((_) async => Left(fakeFailure));
        return buildBloc();
      },
      act: (bloc) => bloc.add(GetAdresses()),
      expect: () => [
        const AdressesStates(
            status: RequestStates.loading, selectedAddress: ''),
        AdressesStates(
            status: RequestStates.failure,
            selectedAddress: '',
            errorMessage: fakeFailure.message),
      ],
    );
  });

  group('AdressesBloc - selectedAddress staleness regression', () {
    blocTest<AdressesBloc, AdressesStates>(
      'selectedAddress reflects the latest cached value (not the one seeded at construction) when GetAdresses is re-dispatched after another bloc instance changed the selection',
      setUp: () async {
        // Seed the cache the way it would look when this bloc instance is
        // first constructed.
        SharedPreferences.setMockInitialValues({adressIDKey: 'addr-1'});
        await CacheHelper.init();
      },
      build: () {
        when(() => mockGetAdressesUseCase.call())
            .thenAnswer((_) async => const Right([fakeAddress]));
        // Constructed while the cache still holds 'addr-1', so the bloc's
        // initial state seeds selectedAddress = 'addr-1'.
        return buildBloc();
      },
      act: (bloc) async {
        // Simulate a different AdressesBloc instance elsewhere in the app
        // changing the selected address in the cache after this bloc was
        // constructed but before GetAdresses is dispatched on it.
        await CacheHelper.saveData(key: adressIDKey, value: 'addr-2');
        bloc.add(GetAdresses());
      },
      expect: () => [
        const AdressesStates(
            status: RequestStates.loading, selectedAddress: 'addr-1'),
        const AdressesStates(
            status: RequestStates.success,
            selectedAddress: 'addr-2',
            adresses: [fakeAddress]),
      ],
      verify: (bloc) {
        expect(bloc.state.selectedAddress, equals('addr-2'));
      },
    );

    test(
        'constructor seeds selectedAddress from the cache value present at construction time',
        () async {
      SharedPreferences.setMockInitialValues({adressIDKey: 'addr-1'});
      await CacheHelper.init();

      final bloc = buildBloc();

      expect(bloc.state.selectedAddress, equals('addr-1'));
      await bloc.close();
    });
  });
}
