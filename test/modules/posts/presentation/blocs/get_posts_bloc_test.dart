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

  group("GetPostsBloc", () {
    test("initial state should be GetPostsInitial", () {
      expect(bloc.state, isA<GetPostsInitial>());
    });

    group("loadPosts", () {
      blocTest<GetPostsBloc, GetPostsState>(
        "emits states including GetPostsLoading and GetPostsSuccess when loadPosts succeeds",
        build: () {
          when(
            () => mockUseCase.call(),
          ).thenAnswer((_) async => tSuccessResult);
          return GetPostsBloc(mockUseCase);
        },
        act: (bloc) => bloc.loadPosts(),
        wait: const Duration(milliseconds: 1600),
        verify: (bloc) {
          final state = bloc.state;
          if (state is GetPostsSuccess) {
            expect(state.posts.length, 10);
            expect(state.hasMore, true);
          } else {
            fail("Last state should be GetPostsSuccess");
          }
        },
      );

      blocTest<GetPostsBloc, GetPostsState>(
        "emits GetPostsError when loadPosts fails",
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
        // Wait for async operations and delay
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

        // After loading first page, hasMore should be true (25 posts, showing 10)
        final state = bloc.state as GetPostsSuccess;
        expect(state.hasMore, true);
        expect(state.posts.length, 10);
      });

      test("loadMore does nothing when already loading", () async {
        when(() => mockUseCase.call()).thenAnswer((_) async => tSuccessResult);

        bloc.loadPosts();
        await Future.delayed(const Duration(milliseconds: 2000));

        // Start loadMore
        bloc.loadMore();
        // Try to call loadMore again immediately
        bloc.loadMore();

        await Future.delayed(const Duration(milliseconds: 2000));

        // Should have loaded second page (20 posts)
        final state = bloc.state as GetPostsSuccess;
        expect(state.posts.length, 20);
      });

      test("loadMore does not call useCase again", () async {
        when(() => mockUseCase.call()).thenAnswer((_) async => tSuccessResult);

        bloc.loadPosts();
        await Future.delayed(const Duration(milliseconds: 2000));
        bloc.loadMore();
        await Future.delayed(const Duration(milliseconds: 2000));

        // UseCase should only be called once (in loadPosts)
        verify(() => mockUseCase.call()).called(1);
      });
    });
  });
}
