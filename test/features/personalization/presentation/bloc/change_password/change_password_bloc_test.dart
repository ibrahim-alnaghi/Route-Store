import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/constants/enums.dart';
import 'package:route_store/core/constants/keys_constants.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/core/local_storage/cache_helper.dart';
import 'package:route_store/features/authentication/data/models/change_password_request_body.dart';
import 'package:route_store/features/authentication/domain/usecases/change_password_use_case.dart';
import 'package:route_store/features/personalization/presentation/bloc/change_password/change_password_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockChangePasswordUseCase extends Mock implements ChangePasswordUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockChangePasswordUseCase mockChangePasswordUseCase;

  final fakeFailure = ServerFailures('Wrong current password');

  setUpAll(() {
    registerFallbackValue(ChangePasswordRequestBody(
        currentPassword: '', password: '', rePassword: ''));
  });

  setUp(() {
    mockChangePasswordUseCase = MockChangePasswordUseCase();
  });

  ChangePasswordBloc buildBloc() =>
      ChangePasswordBloc(changePasswordUseCase: mockChangePasswordUseCase);

  group('ChangePasswordBloc - SubmitChangePassword', () {
    blocTest<ChangePasswordBloc, ChangePasswordStates>(
      'emits [loading, success] and clears the cached user (forced logout) when the change succeeds',
      setUp: () async {
        // Seed the cache with a fake user value first so the removal is
        // actually observable.
        SharedPreferences.setMockInitialValues(
            {userkey: '{"userName":"Test User"}'});
        await CacheHelper.init();
      },
      build: () {
        when(() => mockChangePasswordUseCase.call(any()))
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) {
        bloc.currentPassword.text = 'dummy-current-pass';
        bloc.newPassword.text = 'dummy-new-pass';
        bloc.confirmPassword.text = 'dummy-new-pass';
        bloc.add(SubmitChangePassword());
      },
      expect: () => [
        const ChangePasswordStates(status: RequestStates.loading),
        const ChangePasswordStates(status: RequestStates.success),
      ],
      verify: (_) {
        expect(CacheHelper.getData(userkey), isNull);
      },
    );

    blocTest<ChangePasswordBloc, ChangePasswordStates>(
      'emits [loading, failure] with errorMessage and leaves the cache untouched when the change fails',
      setUp: () async {
        SharedPreferences.setMockInitialValues(
            {userkey: '{"userName":"Test User"}'});
        await CacheHelper.init();
      },
      build: () {
        when(() => mockChangePasswordUseCase.call(any()))
            .thenAnswer((_) async => Left(fakeFailure));
        return buildBloc();
      },
      act: (bloc) {
        bloc.currentPassword.text = 'wrong-current-pass';
        bloc.newPassword.text = 'dummy-new-pass';
        bloc.confirmPassword.text = 'dummy-new-pass';
        bloc.add(SubmitChangePassword());
      },
      expect: () => [
        const ChangePasswordStates(status: RequestStates.loading),
        ChangePasswordStates(
            status: RequestStates.failure, errorMessage: fakeFailure.message),
      ],
      verify: (_) {
        expect(CacheHelper.getData(userkey), isNotNull);
      },
    );

    blocTest<ChangePasswordBloc, ChangePasswordStates>(
      'calls the use case with the values taken from the controllers',
      setUp: () async {
        SharedPreferences.setMockInitialValues({});
        await CacheHelper.init();
      },
      build: () {
        when(() => mockChangePasswordUseCase.call(any()))
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) {
        bloc.currentPassword.text = 'dummy-current-pass';
        bloc.newPassword.text = 'dummy-brand-new-pass';
        bloc.confirmPassword.text = 'dummy-brand-new-pass';
        bloc.add(SubmitChangePassword());
      },
      verify: (_) {
        final captured =
            verify(() => mockChangePasswordUseCase.call(captureAny())).captured;
        final body = captured.first as ChangePasswordRequestBody;
        expect(body.currentPassword, equals('dummy-current-pass'));
        expect(body.password, equals('dummy-brand-new-pass'));
        expect(body.rePassword, equals('dummy-brand-new-pass'));
      },
    );
  });

  group('ChangePasswordBloc - visibility toggles', () {
    blocTest<ChangePasswordBloc, ChangePasswordStates>(
      'ToggleCurrentPasswordVisibility flips only showCurrentPassword',
      build: buildBloc,
      act: (bloc) => bloc.add(ToggleCurrentPasswordVisibility()),
      expect: () => [
        const ChangePasswordStates(
          status: RequestStates.initial,
          showCurrentPassword: true,
        ),
      ],
    );

    blocTest<ChangePasswordBloc, ChangePasswordStates>(
      'ToggleNewPasswordVisibility flips only showNewPassword',
      build: buildBloc,
      act: (bloc) => bloc.add(ToggleNewPasswordVisibility()),
      expect: () => [
        const ChangePasswordStates(
          status: RequestStates.initial,
          showNewPassword: true,
        ),
      ],
    );

    blocTest<ChangePasswordBloc, ChangePasswordStates>(
      'ToggleConfirmPasswordVisibility flips only showConfirmPassword',
      build: buildBloc,
      act: (bloc) => bloc.add(ToggleConfirmPasswordVisibility()),
      expect: () => [
        const ChangePasswordStates(
          status: RequestStates.initial,
          showConfirmPassword: true,
        ),
      ],
    );

    blocTest<ChangePasswordBloc, ChangePasswordStates>(
      'each toggle only affects its own flag, independent of the others',
      build: buildBloc,
      act: (bloc) {
        bloc.add(ToggleCurrentPasswordVisibility());
        bloc.add(ToggleNewPasswordVisibility());
        bloc.add(ToggleConfirmPasswordVisibility());
        bloc.add(ToggleCurrentPasswordVisibility());
      },
      expect: () => [
        const ChangePasswordStates(
            status: RequestStates.initial, showCurrentPassword: true),
        const ChangePasswordStates(
            status: RequestStates.initial,
            showCurrentPassword: true,
            showNewPassword: true),
        const ChangePasswordStates(
            status: RequestStates.initial,
            showCurrentPassword: true,
            showNewPassword: true,
            showConfirmPassword: true),
        const ChangePasswordStates(
            status: RequestStates.initial,
            showCurrentPassword: false,
            showNewPassword: true,
            showConfirmPassword: true),
      ],
    );
  });

  group('ChangePasswordBloc - disposal', () {
    test(
        'close() disposes currentPassword, newPassword, and confirmPassword controllers',
        () async {
      final bloc = buildBloc();

      await bloc.close();

      expect(() => bloc.currentPassword.addListener(() {}), throwsFlutterError);
      expect(() => bloc.newPassword.addListener(() {}), throwsFlutterError);
      expect(() => bloc.confirmPassword.addListener(() {}), throwsFlutterError);
    });
  });
}
