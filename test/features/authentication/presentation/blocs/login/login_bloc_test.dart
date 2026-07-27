import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:route_store/core/constants/enums.dart';
import 'package:route_store/core/failures/server_failures.dart';
import 'package:route_store/features/authentication/data/models/login_model/login_model.dart';
import 'package:route_store/features/authentication/data/models/login_model/login_request_body.dart';
import 'package:route_store/features/authentication/domain/usecases/login_use_case.dart';
import 'package:route_store/features/authentication/presentation/blocs/login/login_bloc.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockLoginUseCase mockLoginUseCase;

  setUpAll(() {
    registerFallbackValue(LoginRequestBody(email: '', password: ''));
  });

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
  });

  final fakeLoginModel = LoginModel(token: 'tok123', message: 'success');
  final fakeFailure = ServerFailures('Invalid credentials');

  group('LoginBloc', () {
    test('initial state has status initial and showPassword false', () {
      final bloc = LoginBloc(loginUseCase: mockLoginUseCase);
      expect(bloc.state,
          const LoginStates(status: RequestStates.initial, showPassword: false));
      bloc.close();
    });

    blocTest<LoginBloc, LoginStates>(
      'emits [loading, success] when Login event succeeds',
      build: () {
        when(() => mockLoginUseCase.call(any()))
            .thenAnswer((_) async => Right(fakeLoginModel));
        return LoginBloc(loginUseCase: mockLoginUseCase);
      },
      act: (bloc) {
        bloc.email.text = 'user@example.com';
        bloc.password.text = 'dummy-login-pass-1';
        bloc.add(Login());
      },
      expect: () => [
        const LoginStates(status: RequestStates.loading),
        LoginStates(status: RequestStates.success, user: fakeLoginModel),
      ],
    );

    blocTest<LoginBloc, LoginStates>(
      'emits [loading, failure] with errorMessage when Login event fails',
      build: () {
        when(() => mockLoginUseCase.call(any()))
            .thenAnswer((_) async => Left(fakeFailure));
        return LoginBloc(loginUseCase: mockLoginUseCase);
      },
      act: (bloc) {
        bloc.email.text = 'user@example.com';
        bloc.password.text = 'dummy-login-pass-2';
        bloc.add(Login());
      },
      expect: () => [
        const LoginStates(status: RequestStates.loading),
        const LoginStates(
          status: RequestStates.failure,
          errorMessage: 'Invalid credentials',
        ),
      ],
    );

    blocTest<LoginBloc, LoginStates>(
      'calls use case with email and password taken from the controllers',
      build: () {
        when(() => mockLoginUseCase.call(any()))
            .thenAnswer((_) async => Right(fakeLoginModel));
        return LoginBloc(loginUseCase: mockLoginUseCase);
      },
      act: (bloc) {
        bloc.email.text = 'check@test.com';
        bloc.password.text = 'dummy-login-pass-3';
        bloc.add(Login());
      },
      verify: (bloc) {
        final captured =
            verify(() => mockLoginUseCase.call(captureAny())).captured;
        final body = captured.first as LoginRequestBody;
        expect(body.email, equals('check@test.com'));
        expect(body.password, equals('dummy-login-pass-3'));
      },
    );

    blocTest<LoginBloc, LoginStates>(
      'emits state with showPassword true after TogglePasswordVisibility',
      build: () => LoginBloc(loginUseCase: mockLoginUseCase),
      act: (bloc) => bloc.add(TogglePasswordVisibility()),
      expect: () => [
        const LoginStates(
          status: RequestStates.initial,
          showPassword: true,
        ),
      ],
    );

    blocTest<LoginBloc, LoginStates>(
      'toggles showPassword back to false on second TogglePasswordVisibility',
      build: () => LoginBloc(loginUseCase: mockLoginUseCase),
      act: (bloc) {
        bloc.add(TogglePasswordVisibility());
        bloc.add(TogglePasswordVisibility());
      },
      expect: () => [
        const LoginStates(status: RequestStates.initial, showPassword: true),
        const LoginStates(status: RequestStates.initial, showPassword: false),
      ],
    );
  });
}
