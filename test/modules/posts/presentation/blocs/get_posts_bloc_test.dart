import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:magnum_posts/modules/posts/core/data/models/post_model.dart";
import "package:magnum_posts/modules/posts/core/domain/use_cases/get_posts/get_posts_use_case.dart";
import "package:magnum_posts/modules/posts/presentation/blocs/get_posts/get_posts_bloc.dart";
import "package:magnum_posts/modules/posts/presentation/blocs/get_posts/get_posts_state.dart";
import "package:mocktail/mocktail.dart";

class MockGetPostsUseCase extends Mock implements GetPostsUseCase {}

void main() {
  late GetPostsBloc bloc;
  late MockGetPostsUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetPostsUseCase();
    bloc = GetPostsBloc(mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  final tPostsList = List.generate(
    25,
    (i) => PostModel(
      id: i + 1,
      title: "Title ${i + 1}",
      body: "Body ${i + 1}",
      userId: i + 1,
    ),
  );
  final tSuccessResult = ResultWrapper.success(tPostsList);
  final tErrorResult = ResultWrapper<List<PostModel>>.error(
    NotFoundError(message: "Posts not found"),
  );

  group("[Presentation] GetPostsBloc", () {
    test("InitialState", () {
      expect(bloc.state, isA<GetPostsInitial>());
    });

    group("loadPosts", () {
      blocTest<GetPostsBloc, GetPostsState>(
        "Bloc Success",
        build: () {
          when(
            () => mockUseCase.call(),
          ).thenAnswer((_) async => tSuccessResult);
          return GetPostsBloc(mockUseCase);
        },
        act: (bloc) => bloc.loadPosts(),
        wait: const Duration(milliseconds: 1600),
        expect: () => [isA<GetPostsLoading>(), isA<GetPostsSuccess>()],
      );

      blocTest<GetPostsBloc, GetPostsState>(
        "Bloc Error",
        build: () {
          when(() => mockUseCase.call()).thenAnswer((_) async => tErrorResult);
          return GetPostsBloc(mockUseCase);
        },
        act: (bloc) => bloc.loadPosts(),
        expect: () => [isA<GetPostsLoading>(), isA<GetPostsError>()],
      );

      test("should load first page of posts (10 items)", () async {
        when(() => mockUseCase.call()).thenAnswer((_) async => tSuccessResult);

        bloc.loadPosts();
        await Future.delayed(const Duration(milliseconds: 2000));

        final state = bloc.state;
        expect(state, isA<GetPostsSuccess>());
        if (state is GetPostsSuccess) {
          expect(state.posts.length, 10);
          expect(state.hasMore, true);
        }
      });
    });

    group("loadMore", () {
      test("hasMore property reflects pagination state", () async {
        when(() => mockUseCase.call()).thenAnswer((_) async => tSuccessResult);

        bloc.loadPosts();
        await Future.delayed(const Duration(milliseconds: 2000));

        final state = bloc.state as GetPostsSuccess;
        expect(state.hasMore, true);
        expect(state.posts.length, 10);
      });

      test("loadMore does nothing when already loading", () async {
        when(() => mockUseCase.call()).thenAnswer((_) async => tSuccessResult);

        bloc.loadPosts();
        await Future.delayed(const Duration(milliseconds: 2000));

        bloc.loadMore();
        bloc.loadMore();

        await Future.delayed(const Duration(milliseconds: 2000));

        final state = bloc.state as GetPostsSuccess;
        expect(state.posts.length, 20);
      });

      test("loadMore does not call useCase again", () async {
        when(() => mockUseCase.call()).thenAnswer((_) async => tSuccessResult);

        bloc.loadPosts();
        await Future.delayed(const Duration(milliseconds: 2000));
        bloc.loadMore();
        await Future.delayed(const Duration(milliseconds: 2000));

        verify(() => mockUseCase.call()).called(1);
      });
    });
  });
}
