import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:magnum_posts/modules/commons/utils/states/base_state.dart";
import "package:magnum_posts/modules/posts/core/domain/entities/author_entity.dart";
import "package:magnum_posts/modules/posts/core/domain/use_cases/get_author_by_id/get_author_by_id_use_case.dart";
import "package:magnum_posts/modules/posts/presentation/blocs/get_author_by_id/get_author_by_id_bloc.dart";
import "package:mocktail/mocktail.dart";

class MockGetAuthorByIdUseCase extends Mock implements GetAuthorByIdUseCase {}

void main() {
  late GetAuthorByIdBloc bloc;
  late MockGetAuthorByIdUseCase mockUseCase;

  const tAuthorId = 1;
  const tAuthor = AuthorEntity(id: 1, name: "John Doe");

  setUp(() {
    mockUseCase = MockGetAuthorByIdUseCase();
    bloc = GetAuthorByIdBloc(mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  group("GetAuthorByIdBloc", () {
    test("initial state should be InitialState", () {
      expect(bloc.state, isA<InitialState>());
    });

    blocTest<GetAuthorByIdBloc, BaseState>(
      "should emit [LoadingState, SuccessState] when use case returns success",
      build: () {
        when(
          () => mockUseCase.call(tAuthorId),
        ).thenAnswer((_) async => ResultWrapper.success(tAuthor));
        return bloc;
      },
      act: (bloc) => bloc.call(tAuthorId),
      expect: () => [
        isA<LoadingState>(),
        isA<SuccessState<AuthorEntity>>().having(
          (state) => state.data,
          "data",
          tAuthor,
        ),
      ],
      verify: (_) {
        verify(() => mockUseCase.call(tAuthorId)).called(1);
      },
    );

    blocTest<GetAuthorByIdBloc, BaseState>(
      "should emit [LoadingState, ErrorState] when use case returns error",
      build: () {
        when(
          () => mockUseCase.call(tAuthorId),
        ).thenAnswer((_) async => ResultWrapper.error(NotFoundError()));
        return bloc;
      },
      act: (bloc) => bloc.call(tAuthorId),
      expect: () => [
        isA<LoadingState>(),
        isA<ErrorState>().having(
          (state) => state.error,
          "error",
          isA<NotFoundError>(),
        ),
      ],
      verify: (_) {
        verify(() => mockUseCase.call(tAuthorId)).called(1);
      },
    );
  });
}
