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

  group("[Presentation] SignInBloc", () {
    test("InitialState", () {
      expect(bloc.state, isA<InitialState>());
    });

    blocTest<SignInBloc, BaseState>(
      "Bloc Success",
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
      "Bloc Error",
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
  });
}
