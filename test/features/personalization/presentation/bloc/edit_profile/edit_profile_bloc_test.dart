import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/constants/enums.dart';
import 'package:route_store/core/constants/keys_constants.dart';
import 'package:route_store/core/di/injection_container.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/core/local_storage/cache_helper.dart';
import 'package:route_store/features/authentication/data/models/update_profile_request_body.dart';
import 'package:route_store/features/authentication/domain/entities/user_entity.dart';
import 'package:route_store/features/authentication/domain/usecases/update_profile_use_case.dart';
import 'package:route_store/features/personalization/presentation/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockUpdateProfileUseCase extends Mock implements UpdateProfileUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockUpdateProfileUseCase mockUpdateProfileUseCase;

  const fakeUser = UserEntity(
    userToken: 'tok-1',
    userName: 'Old Name',
    userEmail: 'old@test.com',
  );

  const updatedUser = UserEntity(
    userToken: 'tok-1',
    userName: 'New Name',
    userEmail: 'new@test.com',
  );

  final fakeFailure = ServerFailures('Update failed');

  setUpAll(() {
    registerFallbackValue(UpdateProfileRequestBody(name: '', email: ''));
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await CacheHelper.init();

    mockUpdateProfileUseCase = MockUpdateProfileUseCase();

    if (getIt.isRegistered<UserEntity>()) {
      getIt.unregister<UserEntity>();
    }
    getIt.registerSingleton<UserEntity>(fakeUser);
  });

  tearDown(() {
    if (getIt.isRegistered<UserEntity>()) {
      getIt.unregister<UserEntity>();
    }
  });

  EditProfileBloc buildBloc() =>
      EditProfileBloc(updateProfileUseCase: mockUpdateProfileUseCase);

  group('EditProfileBloc', () {
    test(
        'controllers are pre-filled from getIt<UserEntity>() at construction time',
        () {
      final bloc = buildBloc();

      expect(bloc.name.text, equals('Old Name'));
      expect(bloc.email.text, equals('old@test.com'));

      bloc.close();
    });

    blocTest<EditProfileBloc, EditProfileStates>(
      'emits [loading, success] and persists the updated user to the cache when SubmitUpdateProfile succeeds',
      build: () {
        when(() => mockUpdateProfileUseCase.call(any()))
            .thenAnswer((_) async => const Right(updatedUser));
        return buildBloc();
      },
      act: (bloc) {
        bloc.name.text = 'New Name';
        bloc.email.text = 'new@test.com';
        bloc.add(SubmitUpdateProfile());
      },
      expect: () => [
        const EditProfileStates(status: RequestStates.loading),
        const EditProfileStates(status: RequestStates.success),
      ],
      verify: (_) {
        expect(CacheHelper.getMapData(userkey), equals(updatedUser.toMap()));
      },
    );

    blocTest<EditProfileBloc, EditProfileStates>(
      'emits [loading, failure] with errorMessage and does NOT modify the cache when SubmitUpdateProfile fails',
      build: () {
        when(() => mockUpdateProfileUseCase.call(any()))
            .thenAnswer((_) async => Left(fakeFailure));
        return buildBloc();
      },
      act: (bloc) => bloc.add(SubmitUpdateProfile()),
      expect: () => [
        const EditProfileStates(status: RequestStates.loading),
        EditProfileStates(
            status: RequestStates.failure, errorMessage: fakeFailure.message),
      ],
      verify: (_) {
        expect(CacheHelper.getMapData(userkey), isNull);
      },
    );

    blocTest<EditProfileBloc, EditProfileStates>(
      'calls the use case with the trimmed values from the controllers',
      build: () {
        when(() => mockUpdateProfileUseCase.call(any()))
            .thenAnswer((_) async => const Right(updatedUser));
        return buildBloc();
      },
      act: (bloc) {
        bloc.name.text = '  Jane Doe  ';
        bloc.email.text = '  jane@test.com  ';
        bloc.add(SubmitUpdateProfile());
      },
      verify: (_) {
        final captured =
            verify(() => mockUpdateProfileUseCase.call(captureAny())).captured;
        final body = captured.first as UpdateProfileRequestBody;
        expect(body.name, equals('Jane Doe'));
        expect(body.email, equals('jane@test.com'));
      },
    );
  });

  group('EditProfileBloc - disposal', () {
    test('close() disposes the name and email controllers', () async {
      final bloc = buildBloc();

      await bloc.close();

      expect(() => bloc.name.addListener(() {}), throwsFlutterError);
      expect(() => bloc.email.addListener(() {}), throwsFlutterError);
    });
  });
}
