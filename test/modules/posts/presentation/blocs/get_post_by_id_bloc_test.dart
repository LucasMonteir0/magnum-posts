import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:magnum_posts/modules/commons/utils/states/base_state.dart";
import "package:magnum_posts/modules/posts/core/domain/entities/post_entity.dart";
import "package:magnum_posts/modules/posts/core/domain/use_cases/get_post_by_id/get_post_by_id_use_case.dart";
import "package:magnum_posts/modules/posts/presentation/blocs/get_post_by_id/get_post_by_id_bloc.dart";
import "package:mocktail/mocktail.dart";

class MockGetPostByIdUseCase extends Mock implements GetPostByIdUseCase {}

void main() {
  late GetPostByIdBloc bloc;
  late MockGetPostByIdUseCase mockUseCase;

  const tPostId = 1;
  const tPost = PostEntity(
    id: 1,
    title: "Test Post",
    body: "Test Body",
    userId: 1,
  );

  setUp(() {
    mockUseCase = MockGetPostByIdUseCase();
    bloc = GetPostByIdBloc(mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  group("[Presentation] GetPostByIdBloc", () {
    test("InitialState", () {
      expect(bloc.state, isA<InitialState>());
    });

    blocTest<GetPostByIdBloc, BaseState>(
      "Bloc Success",
      build: () {
        when(
          () => mockUseCase.call(tPostId),
        ).thenAnswer((_) async => ResultWrapper.success(tPost));
        return bloc;
      },
      act: (bloc) => bloc.call(tPostId),
      expect: () => [isA<LoadingState>(), isA<SuccessState<PostEntity>>()],
      verify: (_) {
        verify(() => mockUseCase.call(tPostId)).called(1);
      },
    );

    blocTest<GetPostByIdBloc, BaseState>(
      "Bloc Error",
      build: () {
        when(
          () => mockUseCase.call(tPostId),
        ).thenAnswer((_) async => ResultWrapper.error(NotFoundError()));
        return bloc;
      },
      act: (bloc) => bloc.call(tPostId),
      expect: () => [isA<LoadingState>(), isA<ErrorState>()],
      verify: (_) {
        verify(() => mockUseCase.call(tPostId)).called(1);
      },
    );
  });
}
