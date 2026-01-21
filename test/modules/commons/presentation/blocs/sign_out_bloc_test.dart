import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/core/domain/use_cases/sign_out/sign_out_use_case.dart";
import "package:magnum_posts/modules/commons/presentation/blocs/sign_out_bloc.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:magnum_posts/modules/commons/utils/states/base_state.dart";
import "package:mocktail/mocktail.dart";

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

void main() {
  late SignOutBloc bloc;
  late MockSignOutUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockSignOutUseCase();
    bloc = SignOutBloc(mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  final tSuccessResult = ResultWrapper.success(true);
  final tErrorResult = ResultWrapper<bool>.error(
    UnknownError(message: "Sign out failed"),
  );

  group("SignOutBloc", () {
    test("initial state should be InitialState", () {
      expect(bloc.state, isA<InitialState>());
    });

    group("call", () {
      blocTest<SignOutBloc, BaseState>(
        "emits [LoadingState, SuccessState] when signOut succeeds",
        build: () {
          when(
            () => mockUseCase.call(),
          ).thenAnswer((_) async => tSuccessResult);
          return SignOutBloc(mockUseCase);
        },
        act: (bloc) => bloc.call(),
        expect: () => [isA<LoadingState>(), isA<SuccessState<bool>>()],
        verify: (_) {
          verify(() => mockUseCase.call()).called(1);
        },
      );

      blocTest<SignOutBloc, BaseState>(
        "emits [LoadingState, ErrorState] when signOut fails",
        build: () {
          when(() => mockUseCase.call()).thenAnswer((_) async => tErrorResult);
          return SignOutBloc(mockUseCase);
        },
        act: (bloc) => bloc.call(),
        expect: () => [isA<LoadingState>(), isA<ErrorState>()],
        verify: (_) {
          verify(() => mockUseCase.call()).called(1);
        },
      );

      blocTest<SignOutBloc, BaseState>(
        "SuccessState contains true when signOut succeeds",
        build: () {
          when(
            () => mockUseCase.call(),
          ).thenAnswer((_) async => tSuccessResult);
          return SignOutBloc(mockUseCase);
        },
        act: (bloc) => bloc.call(),
        verify: (bloc) {
          final state = bloc.state;
          expect(state, isA<SuccessState<bool>>());
          expect((state as SuccessState<bool>).data, true);
        },
      );

      blocTest<SignOutBloc, BaseState>(
        "ErrorState contains the error from result when signOut fails",
        build: () {
          when(() => mockUseCase.call()).thenAnswer((_) async => tErrorResult);
          return SignOutBloc(mockUseCase);
        },
        act: (bloc) => bloc.call(),
        verify: (bloc) {
          final state = bloc.state;
          expect(state, isA<ErrorState>());
          expect((state as ErrorState).error, isA<UnknownError>());
        },
      );
    });
  });
}
