import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/constants/enums.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/authentication/data/models/signup_model/signup_model.dart';
import 'package:route_store/features/authentication/data/models/signup_model/signup_request_body.dart';
import 'package:route_store/features/authentication/domain/usecases/sign_up_use_case.dart';
import 'package:route_store/features/authentication/presentation/blocs/signup/signup_bloc.dart';

class MockSignupUseCase extends Mock implements SignupUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSignupUseCase mockSignupUseCase;

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
    mockSignupUseCase = MockSignupUseCase();
  });

  final fakeSignupModel = SignupModel(token: 'tok789', message: 'created');
  final fakeFailure = ServerFailures('Email already in use');

  group('SignupBloc', () {
    test('initial state has status initial with all boolean flags false', () {
      final bloc = SignupBloc(signupUseCase: mockSignupUseCase);
      expect(
        bloc.state,
        const SignupStates(
          status: RequestStates.initial,
          agreedToTerms: false,
          showPassword: false,
          showConfirmPassword: false,
        ),
      );
      bloc.close();
    });

    blocTest<SignupBloc, SignupStates>(
      'emits [loading, success] when SignUp event succeeds',
      build: () {
        when(() => mockSignupUseCase.call(any()))
            .thenAnswer((_) async => Right(fakeSignupModel));
        return SignupBloc(signupUseCase: mockSignupUseCase);
      },
      act: (bloc) {
        bloc.firstName.text = 'John';
        bloc.lastName.text = 'Doe';
        bloc.email.text = 'john@example.com';
        bloc.password.text = 'dummy-signup-pass-1';
        bloc.confirmPassword.text = 'dummy-signup-pass-1';
        bloc.phone.text = '01012345678';
        bloc.add(SignUp());
      },
      expect: () => [
        const SignupStates(status: RequestStates.loading),
        SignupStates(status: RequestStates.success, user: fakeSignupModel),
      ],
    );

    blocTest<SignupBloc, SignupStates>(
      'emits [loading, failure] with errorMessage when SignUp event fails',
      build: () {
        when(() => mockSignupUseCase.call(any()))
            .thenAnswer((_) async => Left(fakeFailure));
        return SignupBloc(signupUseCase: mockSignupUseCase);
      },
      act: (bloc) {
        bloc.firstName.text = 'Jane';
        bloc.lastName.text = 'Smith';
        bloc.email.text = 'jane@example.com';
        bloc.password.text = 'dummy-signup-pass-2';
        bloc.confirmPassword.text = 'dummy-signup-pass-2';
        bloc.phone.text = '01098765432';
        bloc.add(SignUp());
      },
      expect: () => [
        const SignupStates(status: RequestStates.loading),
        const SignupStates(
          status: RequestStates.failure,
          errorMessage: 'Email already in use',
        ),
      ],
    );

    blocTest<SignupBloc, SignupStates>(
      'builds signup body with concatenated first and last name from controllers',
      build: () {
        when(() => mockSignupUseCase.call(any()))
            .thenAnswer((_) async => Right(fakeSignupModel));
        return SignupBloc(signupUseCase: mockSignupUseCase);
      },
      act: (bloc) {
        bloc.firstName.text = 'Alice';
        bloc.lastName.text = 'Wonder';
        bloc.email.text = 'alice@example.com';
        bloc.password.text = 'dummy-signup-pass-3';
        bloc.confirmPassword.text = 'dummy-signup-pass-3';
        bloc.phone.text = '01011111111';
        bloc.add(SignUp());
      },
      verify: (bloc) {
        final captured =
            verify(() => mockSignupUseCase.call(captureAny())).captured;
        final body = captured.first as SignupRequestBody;
        expect(body.name, equals('Alice Wonder'));
        expect(body.email, equals('alice@example.com'));
        expect(body.phone, equals('01011111111'));
      },
    );

    blocTest<SignupBloc, SignupStates>(
      'emits state with agreedToTerms true after ToggleAgreedToTerms',
      build: () => SignupBloc(signupUseCase: mockSignupUseCase),
      act: (bloc) => bloc.add(ToggleAgreedToTerms()),
      expect: () => [
        const SignupStates(
          status: RequestStates.initial,
          agreedToTerms: true,
        ),
      ],
    );

    blocTest<SignupBloc, SignupStates>(
      'toggles agreedToTerms back to false on second ToggleAgreedToTerms',
      build: () => SignupBloc(signupUseCase: mockSignupUseCase),
      act: (bloc) {
        bloc.add(ToggleAgreedToTerms());
        bloc.add(ToggleAgreedToTerms());
      },
      expect: () => [
        const SignupStates(status: RequestStates.initial, agreedToTerms: true),
        const SignupStates(status: RequestStates.initial, agreedToTerms: false),
      ],
    );

    blocTest<SignupBloc, SignupStates>(
      'emits state with showPassword true after TogglePasswordVisibility',
      build: () => SignupBloc(signupUseCase: mockSignupUseCase),
      act: (bloc) => bloc.add(TogglePasswordVisibility()),
      expect: () => [
        const SignupStates(
          status: RequestStates.initial,
          showPassword: true,
        ),
      ],
    );

    blocTest<SignupBloc, SignupStates>(
      'emits state with showConfirmPassword true after ToggleConfirmPasswordVisibility',
      build: () => SignupBloc(signupUseCase: mockSignupUseCase),
      act: (bloc) => bloc.add(ToggleConfirmPasswordVisibility()),
      expect: () => [
        const SignupStates(
          status: RequestStates.initial,
          showConfirmPassword: true,
        ),
      ],
    );

    blocTest<SignupBloc, SignupStates>(
      'toggles showConfirmPassword back to false on second ToggleConfirmPasswordVisibility',
      build: () => SignupBloc(signupUseCase: mockSignupUseCase),
      act: (bloc) {
        bloc.add(ToggleConfirmPasswordVisibility());
        bloc.add(ToggleConfirmPasswordVisibility());
      },
      expect: () => [
        const SignupStates(
            status: RequestStates.initial, showConfirmPassword: true),
        const SignupStates(
            status: RequestStates.initial, showConfirmPassword: false),
      ],
    );
  });
}
