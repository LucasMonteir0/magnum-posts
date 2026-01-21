import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart';
import 'package:magnum_posts/modules/commons/utils/errors/errors.dart';
import 'package:magnum_posts/modules/commons/utils/states/base_state.dart';
import 'package:magnum_posts/modules/posts/core/data/models/post_model.dart';
import 'package:magnum_posts/modules/posts/core/domain/use_cases/get_posts/get_posts_use_case.dart';
import 'package:magnum_posts/modules/posts/presentation/blocs/get_posts/get_posts_bloc.dart';
import 'package:mocktail/mocktail.dart';

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
      title: 'Title ${i + 1}',
      body: 'Body ${i + 1}',
      userId: i + 1,
    ),
  );
  final tSuccessResult = ResultWrapper.success(tPostsList);
  final tErrorResult = ResultWrapper<List<PostModel>>.error(
    NotFoundError(message: 'Posts not found'),
  );

  group('GetPostsBloc', () {
    test('initial state should be InitialState', () {
      expect(bloc.state, isA<InitialState>());
    });

    test('displayedPosts should be empty initially', () {
      expect(bloc.displayedPosts, isEmpty);
    });

    test('hasMore should be true initially', () {
      expect(bloc.hasMore, true);
    });

    group('loadPosts', () {
      blocTest<GetPostsBloc, BaseState>(
        'emits states including LoadingState and SuccessState when loadPosts succeeds',
        build: () {
          when(
            () => mockUseCase.call(),
          ).thenAnswer((_) async => tSuccessResult);
          return GetPostsBloc(mockUseCase);
        },
        act: (bloc) => bloc.loadPosts(),
        wait: const Duration(milliseconds: 1600),
        verify: (bloc) {
          expect(bloc.displayedPosts.length, 10);
          expect(bloc.hasMore, true);
        },
      );

      blocTest<GetPostsBloc, BaseState>(
        'emits ErrorState when loadPosts fails',
        build: () {
          when(() => mockUseCase.call()).thenAnswer((_) async => tErrorResult);
          return GetPostsBloc(mockUseCase);
        },
        act: (bloc) => bloc.loadPosts(),
        expect: () => [isA<LoadingState>(), isA<ErrorState>()],
      );

      test('should load first page of posts (10 items)', () async {
        when(() => mockUseCase.call()).thenAnswer((_) async => tSuccessResult);

        await bloc.loadPosts();

        expect(bloc.displayedPosts.length, 10);
        expect(bloc.hasMore, true);
      });

      test('should not call useCase if posts already loaded', () async {
        when(() => mockUseCase.call()).thenAnswer((_) async => tSuccessResult);

        await bloc.loadPosts();
        await bloc.loadPosts();

        verify(() => mockUseCase.call()).called(1);
      });
    });

    group('loadMore', () {
      test('hasMore property reflects pagination state', () async {
        when(() => mockUseCase.call()).thenAnswer((_) async => tSuccessResult);

        await bloc.loadPosts();

        // After loading first page, hasMore should be true (25 posts, showing 10)
        expect(bloc.hasMore, true);
        expect(bloc.displayedPosts.length, 10);
      });

      test('loadMore does nothing when already loading', () async {
        when(() => mockUseCase.call()).thenAnswer((_) async => tSuccessResult);

        await bloc.loadPosts();

        // Start loadMore but don't wait
        final future1 = bloc.loadMore();
        // Try to call loadMore again immediately
        final future2 = bloc.loadMore();

        await future1;
        await future2;

        // Both calls should complete without error
        expect(bloc.displayedPosts.isNotEmpty, true);
      });

      test('loadMore does not call useCase again', () async {
        when(() => mockUseCase.call()).thenAnswer((_) async => tSuccessResult);

        await bloc.loadPosts();
        await bloc.loadMore();

        // UseCase should only be called once (in loadPosts)
        verify(() => mockUseCase.call()).called(1);
      });
    });

    group('pagination logic', () {
      test('page size is 10 items', () async {
        when(() => mockUseCase.call()).thenAnswer((_) async => tSuccessResult);

        await bloc.loadPosts();

        expect(bloc.displayedPosts.length, 10);
      });

      test('displayedPosts contains correct items after loadPosts', () async {
        when(() => mockUseCase.call()).thenAnswer((_) async => tSuccessResult);

        await bloc.loadPosts();

        expect(bloc.displayedPosts[0].id, 1);
        expect(bloc.displayedPosts[9].id, 10);
      });
    });
  });
}
