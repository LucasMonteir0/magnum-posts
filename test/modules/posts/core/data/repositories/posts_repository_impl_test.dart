import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:magnum_posts/modules/posts/core/data/datasources/posts_datasource.dart";
import "package:magnum_posts/modules/posts/core/data/models/author_model.dart";
import "package:magnum_posts/modules/posts/core/data/models/post_model.dart";
import "package:magnum_posts/modules/posts/core/data/repositories/posts_repository_impl.dart";
import "package:magnum_posts/modules/posts/core/domain/repositories/posts_repository.dart";
import "package:mocktail/mocktail.dart";

class MockPostsDatasource extends Mock implements PostsDatasource {}

void main() {
  late PostsRepository repository;
  late MockPostsDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockPostsDatasource();
    repository = PostsRepositoryImpl(mockDatasource);
  });

  group("[DATA] PostsRepository", () {
    group("getPosts", () {
      final tPostsList = [
        const PostModel(id: 1, title: "Title 1", body: "Body 1", userId: 1),
        const PostModel(id: 2, title: "Title 2", body: "Body 2", userId: 2),
      ];

      test("When DataSource Success", () async {
        final tSuccessResult = ResultWrapper.success(tPostsList);
        when(
          () => mockDatasource.getPosts(),
        ).thenAnswer((_) async => tSuccessResult);

        final result = await repository.getPosts();

        expect(result.isSuccess, true);
        expect(result.data, tPostsList);
        verify(() => mockDatasource.getPosts()).called(1);
        verifyNoMoreInteractions(mockDatasource);
      });

      test("When DataSource Error", () async {
        final tErrorResult = ResultWrapper<List<PostModel>>.error(
          BadRequestError(message: "Failed to get posts"),
        );
        when(
          () => mockDatasource.getPosts(),
        ).thenAnswer((_) async => tErrorResult);

        final result = await repository.getPosts();

        expect(result.isSuccess, false);
        expect(result.error, isA<BadRequestError>());
        verify(() => mockDatasource.getPosts()).called(1);
        verifyNoMoreInteractions(mockDatasource);
      });
    });

    group("getPostById", () {
      const tPostModel = PostModel(
        id: 1,
        title: "Title",
        body: "Body",
        userId: 1,
      );

      test("When DataSource Success", () async {
        final tSuccessResult = ResultWrapper.success(tPostModel);
        when(
          () => mockDatasource.getPostById(any()),
        ).thenAnswer((_) async => tSuccessResult);

        final result = await repository.getPostById(1);

        expect(result.isSuccess, true);
        expect(result.data, tPostModel);
        verify(() => mockDatasource.getPostById(1)).called(1);
        verifyNoMoreInteractions(mockDatasource);
      });

      test("When DataSource Error", () async {
        final tErrorResult = ResultWrapper<PostModel>.error(
          BadRequestError(message: "Post not found"),
        );
        when(
          () => mockDatasource.getPostById(any()),
        ).thenAnswer((_) async => tErrorResult);

        final result = await repository.getPostById(1);

        expect(result.isSuccess, false);
        expect(result.error, isA<BadRequestError>());
        verify(() => mockDatasource.getPostById(1)).called(1);
        verifyNoMoreInteractions(mockDatasource);
      });
    });

    group("getAuthorById", () {
      const tAuthorModel = AuthorModel(id: 1, name: "John Doe");

      test("When DataSource Success", () async {
        final tSuccessResult = ResultWrapper.success(tAuthorModel);
        when(
          () => mockDatasource.getAuthorById(any()),
        ).thenAnswer((_) async => tSuccessResult);

        final result = await repository.getAuthorById(1);

        expect(result.isSuccess, true);
        expect(result.data, tAuthorModel);
        verify(() => mockDatasource.getAuthorById(1)).called(1);
        verifyNoMoreInteractions(mockDatasource);
      });

      test("When DataSource Error", () async {
        final tErrorResult = ResultWrapper<AuthorModel>.error(
          BadRequestError(message: "Author not found"),
        );
        when(
          () => mockDatasource.getAuthorById(any()),
        ).thenAnswer((_) async => tErrorResult);

        final result = await repository.getAuthorById(1);

        expect(result.isSuccess, false);
        expect(result.error, isA<BadRequestError>());
        verify(() => mockDatasource.getAuthorById(1)).called(1);
        verifyNoMoreInteractions(mockDatasource);
      });
    });
  });
}
