
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/constants/enums.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/authentication/data/models/reset_password_request_body.dart';
import 'package:route_store/features/authentication/domain/usecases/rest_password_use_case.dart';
import 'package:route_store/features/authentication/domain/usecases/send_code_use_case.dart';
import 'package:route_store/features/authentication/domain/usecases/verify_code_use_case.dart';
import 'package:route_store/features/authentication/presentation/blocs/forgot_password/forgot_password_bloc.dart';

class MockSendCodeUseCase extends Mock implements SendCodeUseCase {}

class MockVerifyCodeUseCase extends Mock implements VerifyCodeUseCase {}

class MockRestPasswordUseCase extends Mock implements RestPasswordUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSendCodeUseCase mockSendCodeUseCase;
  late MockVerifyCodeUseCase mockVerifyCodeUseCase;
  late MockRestPasswordUseCase mockRestPasswordUseCase;

  setUpAll(() {
    registerFallbackValue(ResetPasswordRequestBody(email: '', newPassword: ''));
  });

  setUp(() {
    mockSendCodeUseCase = MockSendCodeUseCase();
    mockVerifyCodeUseCase = MockVerifyCodeUseCase();
    mockRestPasswordUseCase = MockRestPasswordUseCase();
  });

  ForgotPasswordBloc buildBloc() => ForgotPasswordBloc(
        sendCodeUseCase: mockSendCodeUseCase,
        verifyCodeUseCase: mockVerifyCodeUseCase,
        restPasswordUseCase: mockRestPasswordUseCase,
      );

  final fakeFailure = ServerFailures('Something went wrong');

  group('ForgotPasswordBloc', () {
    test('initial state has status initial and showPassword false', () {
      final bloc = buildBloc();
      expect(
        bloc.state,
        const ForgotPasswordStates(
          status: RequestStates.initial,
          showPassword: false,
        ),
      );
      bloc.close();
    });

    // ---------- SendCode ----------

    blocTest<ForgotPasswordBloc, ForgotPasswordStates>(
      'emits [loading, success] with successMessage when SendCode event succeeds',
      build: () {
        when(() => mockSendCodeUseCase.call(any()))
            .thenAnswer((_) async => const Right('Code sent to email'));
        return buildBloc();
      },
      act: (bloc) {
        bloc.email.text = 'user@example.com';
        bloc.add(SendCode());
      },
      expect: () => [
        const ForgotPasswordStates(status: RequestStates.loading),
        const ForgotPasswordStates(
          status: RequestStates.success,
          successMessage: 'Code sent to email',
        ),
      ],
    );

    blocTest<ForgotPasswordBloc, ForgotPasswordStates>(
      'emits [loading, failure] with errorMessage when SendCode event fails',
      build: () {
        when(() => mockSendCodeUseCase.call(any()))
            .thenAnswer((_) async => Left(fakeFailure));
        return buildBloc();
      },
      act: (bloc) {
        bloc.email.text = 'user@example.com';
        bloc.add(SendCode());
      },
      expect: () => [
        const ForgotPasswordStates(status: RequestStates.loading),
        const ForgotPasswordStates(
          status: RequestStates.failure,
          errorMessage: 'Something went wrong',
        ),
      ],
    );

    blocTest<ForgotPasswordBloc, ForgotPasswordStates>(
      'passes email from controller to SendCodeUseCase',
      build: () {
        when(() => mockSendCodeUseCase.call(any()))
            .thenAnswer((_) async => const Right('ok'));
        return buildBloc();
      },
      act: (bloc) {
        bloc.email.text = 'exact@test.com';
        bloc.add(SendCode());
      },
      verify: (_) {
        final captured =
            verify(() => mockSendCodeUseCase.call(captureAny())).captured;
        expect(captured.first, equals('exact@test.com'));
      },
    );

    // ---------- VerifyCode ----------

    blocTest<ForgotPasswordBloc, ForgotPasswordStates>(
      'emits [loading, success] with successMessage when VerifyCode event succeeds',
      build: () {
        when(() => mockVerifyCodeUseCase.call(any()))
            .thenAnswer((_) async => const Right('OTP verified'));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const VerifyCode('123456')),
      expect: () => [
        const ForgotPasswordStates(status: RequestStates.loading),
        const ForgotPasswordStates(
          status: RequestStates.success,
          successMessage: 'OTP verified',
        ),
      ],
    );

    blocTest<ForgotPasswordBloc, ForgotPasswordStates>(
      'emits [loading, failure] with errorMessage when VerifyCode event fails',
      build: () {
        when(() => mockVerifyCodeUseCase.call(any()))
            .thenAnswer((_) async => Left(fakeFailure));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const VerifyCode('000000')),
      expect: () => [
        const ForgotPasswordStates(status: RequestStates.loading),
        const ForgotPasswordStates(
          status: RequestStates.failure,
          errorMessage: 'Something went wrong',
        ),
      ],
    );

    blocTest<ForgotPasswordBloc, ForgotPasswordStates>(
      'passes otpCode from event to VerifyCodeUseCase',
      build: () {
        when(() => mockVerifyCodeUseCase.call(any()))
            .thenAnswer((_) async => const Right('ok'));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const VerifyCode('987654')),
      verify: (_) {
        final captured =
            verify(() => mockVerifyCodeUseCase.call(captureAny())).captured;
        expect(captured.first, equals('987654'));
      },
    );

    // ---------- ResetPassword ----------

    blocTest<ForgotPasswordBloc, ForgotPasswordStates>(
      'emits [loading, success] with successMessage when ResetPassword event succeeds',
      build: () {
        when(() => mockRestPasswordUseCase.call(any()))
            .thenAnswer((_) async => const Right('Password updated'));
        return buildBloc();
      },
      act: (bloc) {
        bloc.email.text = 'user@example.com';
        bloc.newPassword.text = 'dummy-reset-pass';
        bloc.add(ResetPassword());
      },
      expect: () => [
        const ForgotPasswordStates(status: RequestStates.loading),
        const ForgotPasswordStates(
          status: RequestStates.success,
          successMessage: 'Password updated',
        ),
      ],
    );

    blocTest<ForgotPasswordBloc, ForgotPasswordStates>(
      'emits [loading, failure] with errorMessage when ResetPassword event fails',
      build: () {
        when(() => mockRestPasswordUseCase.call(any()))
            .thenAnswer((_) async => Left(fakeFailure));
        return buildBloc();
      },
      act: (bloc) {
        bloc.email.text = 'user@example.com';
        bloc.newPassword.text = 'dummy-reset-pass';
        bloc.add(ResetPassword());
      },
      expect: () => [
        const ForgotPasswordStates(status: RequestStates.loading),
        const ForgotPasswordStates(
          status: RequestStates.failure,
          errorMessage: 'Something went wrong',
        ),
      ],
    );

    blocTest<ForgotPasswordBloc, ForgotPasswordStates>(
      'builds reset body with email and newPassword from controllers',
      build: () {
        when(() => mockRestPasswordUseCase.call(any()))
            .thenAnswer((_) async => const Right('ok'));
        return buildBloc();
      },
      act: (bloc) {
        bloc.email.text = 'verify@test.com';
        bloc.newPassword.text = 'dummy-reset-pass-verify';
        bloc.add(ResetPassword());
      },
      verify: (_) {
        final captured =
            verify(() => mockRestPasswordUseCase.call(captureAny())).captured;
        final body = captured.first as ResetPasswordRequestBody;
        expect(body.email, equals('verify@test.com'));
        expect(body.newPassword, equals('dummy-reset-pass-verify'));
      },
    );

    // ---------- TogglePasswordVisibility ----------

    blocTest<ForgotPasswordBloc, ForgotPasswordStates>(
      'emits state with showPassword true after TogglePasswordVisibility',
      build: buildBloc,
      act: (bloc) => bloc.add(TogglePasswordVisibility()),
      expect: () => [
        const ForgotPasswordStates(
          status: RequestStates.initial,
          showPassword: true,
        ),
      ],
    );

    blocTest<ForgotPasswordBloc, ForgotPasswordStates>(
      'toggles showPassword back to false on second TogglePasswordVisibility',
      build: buildBloc,
      act: (bloc) {
        bloc.add(TogglePasswordVisibility());
        bloc.add(TogglePasswordVisibility());
      },
      expect: () => [
        const ForgotPasswordStates(
            status: RequestStates.initial, showPassword: true),
        const ForgotPasswordStates(
            status: RequestStates.initial, showPassword: false),
      ],
    );
  });
}
