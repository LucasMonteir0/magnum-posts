import 'package:flutter_test/flutter_test.dart';
import 'package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart';
import 'package:magnum_posts/modules/posts/core/data/datasources/posts_datasource.dart';
import 'package:magnum_posts/modules/posts/core/data/models/author_model.dart';
import 'package:magnum_posts/modules/posts/core/data/models/post_model.dart';
import 'package:magnum_posts/modules/posts/core/data/repositories/posts_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockPostsDatasource extends Mock implements PostsDatasource {}

void main() {
  late PostsRepositoryImpl repository;
  late MockPostsDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockPostsDatasource();
    repository = PostsRepositoryImpl(mockDatasource);
  });

  group('PostsRepositoryImpl', () {
    group('getPosts', () {
      final tPostsList = [
        const PostModel(id: 1, title: 'Title 1', body: 'Body 1', userId: 1),
        const PostModel(id: 2, title: 'Title 2', body: 'Body 2', userId: 2),
      ];
      final tSuccessResult = ResultWrapper.success(tPostsList);

      test('should delegate to datasource.getPosts()', () async {
        when(
          () => mockDatasource.getPosts(),
        ).thenAnswer((_) async => tSuccessResult);

        final result = await repository.getPosts();

        expect(result.isSuccess, true);
        expect(result.data, tPostsList);
        verify(() => mockDatasource.getPosts()).called(1);
      });
    });

    group('getPostById', () {
      const tPostModel = PostModel(
        id: 1,
        title: 'Title',
        body: 'Body',
        userId: 1,
      );
      final tSuccessResult = ResultWrapper.success(tPostModel);

      test('should delegate to datasource.getPostById()', () async {
        when(
          () => mockDatasource.getPostById(any()),
        ).thenAnswer((_) async => tSuccessResult);

        final result = await repository.getPostById(1);

        expect(result.isSuccess, true);
        expect(result.data, tPostModel);
        verify(() => mockDatasource.getPostById(1)).called(1);
      });
    });

    group('getAuthorById', () {
      const tAuthorModel = AuthorModel(id: 1, name: 'John Doe');
      final tSuccessResult = ResultWrapper.success(tAuthorModel);

      test('should delegate to datasource.getAuthorById()', () async {
        when(
          () => mockDatasource.getAuthorById(any()),
        ).thenAnswer((_) async => tSuccessResult);

        final result = await repository.getAuthorById(1);

        expect(result.isSuccess, true);
        expect(result.data, tAuthorModel);
        verify(() => mockDatasource.getAuthorById(1)).called(1);
      });
    });
  });
}
