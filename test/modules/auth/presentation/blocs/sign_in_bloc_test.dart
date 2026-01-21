import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/auth/core/domain/use_cases/sign_in/sign_in_use_case.dart";
import "package:magnum_posts/modules/auth/presentation/blocs/sign_in_bloc.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/utils/cache/app_cache.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:magnum_posts/modules/commons/utils/states/base_state.dart";
import "package:mocktail/mocktail.dart";
import "package:shared_preferences/shared_preferences.dart";

class MockSignInUseCase extends Mock implements SignInUseCase {}

void main() {
  late SignInBloc bloc;
  late MockSignInUseCase mockUseCase;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await AppCache.instance.init();
  });

  setUp(() {
    mockUseCase = MockSignInUseCase();
    bloc = SignInBloc(mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  const tEmail = "test@example.com";
  const tPassword = "password123";
  const tUserId = "123456";
  final tSuccessResult = ResultWrapper.success(tUserId);
  final tErrorResult = ResultWrapper<String>.error(
    BadRequestError(message: "Email ou senha incorrentos"),
  );

  group("SignInBloc", () {
    test("initial state should be InitialState", () {
      expect(bloc.state, isA<InitialState>());
    });

    group("call", () {
      blocTest<SignInBloc, BaseState>(
        "emits [LoadingState, SuccessState] when signIn succeeds",
        build: () {
          when(
            () => mockUseCase.call(any(), any()),
          ).thenAnswer((_) async => tSuccessResult);
          return SignInBloc(mockUseCase);
        },
        act: (bloc) => bloc.call(tEmail, tPassword),
        expect: () => [isA<LoadingState>(), isA<SuccessState<bool>>()],
        verify: (_) {
          verify(() => mockUseCase.call(tEmail, tPassword)).called(1);
        },
      );

      blocTest<SignInBloc, BaseState>(
        "emits [LoadingState, ErrorState] when signIn fails",
        build: () {
          when(
            () => mockUseCase.call(any(), any()),
          ).thenAnswer((_) async => tErrorResult);
          return SignInBloc(mockUseCase);
        },
        act: (bloc) => bloc.call(tEmail, tPassword),
        expect: () => [isA<LoadingState>(), isA<ErrorState>()],
        verify: (_) {
          verify(() => mockUseCase.call(tEmail, tPassword)).called(1);
        },
      );

      blocTest<SignInBloc, BaseState>(
        "SuccessState contains true when signIn succeeds",
        build: () {
          when(
            () => mockUseCase.call(any(), any()),
          ).thenAnswer((_) async => tSuccessResult);
          return SignInBloc(mockUseCase);
        },
        act: (bloc) => bloc.call(tEmail, tPassword),
        verify: (bloc) {
          final state = bloc.state;
          expect(state, isA<SuccessState<bool>>());
          expect((state as SuccessState<bool>).data, true);
        },
      );

      blocTest<SignInBloc, BaseState>(
        "ErrorState contains the error from result when signIn fails",
        build: () {
          when(
            () => mockUseCase.call(any(), any()),
          ).thenAnswer((_) async => tErrorResult);
          return SignInBloc(mockUseCase);
        },
        act: (bloc) => bloc.call(tEmail, tPassword),
        verify: (bloc) {
          final state = bloc.state;
          expect(state, isA<ErrorState>());
          expect((state as ErrorState).error, isA<BadRequestError>());
          expect(state.error.message, "Email ou senha incorrentos");
        },
      );

      test("should emit LoadingState first then SuccessState", () async {
        when(
          () => mockUseCase.call(any(), any()),
        ).thenAnswer((_) async => tSuccessResult);

        final states = <BaseState>[];
        bloc.stream.listen(states.add);

        bloc.call(tEmail, tPassword);

        await Future.delayed(const Duration(milliseconds: 100));

        expect(states.length, 2);
        expect(states[0], isA<LoadingState>());
        expect(states[1], isA<SuccessState<bool>>());
      });

      test("should pass correct email and password to useCase", () async {
        when(
          () => mockUseCase.call(any(), any()),
        ).thenAnswer((_) async => tSuccessResult);

        bloc.call(tEmail, tPassword);

        await Future.delayed(const Duration(milliseconds: 100));

        verify(() => mockUseCase.call(tEmail, tPassword)).called(1);
      });
    });
  });
}
