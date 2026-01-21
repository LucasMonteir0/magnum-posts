import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/posts/core/data/models/post_model.dart";
import "package:magnum_posts/modules/posts/core/domain/repositories/posts_repository.dart";
import "package:magnum_posts/modules/posts/core/domain/use_cases/get_post_by_id/get_post_by_id_use_case_impl.dart";
import "package:mocktail/mocktail.dart";

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  late GetPostByIdUseCaseImpl useCase;
  late MockPostsRepository mockRepository;

  setUp(() {
    mockRepository = MockPostsRepository();
    useCase = GetPostByIdUseCaseImpl(mockRepository);
  });

  group("GetPostByIdUseCaseImpl", () {
    const tPostModel = PostModel(
      id: 1,
      title: "Title",
      body: "Body",
      userId: 1,
    );
    final tSuccessResult = ResultWrapper.success(tPostModel);

    test(
      "should delegate to repository.getPostById() with correct id",
      () async {
        when(
          () => mockRepository.getPostById(any()),
        ).thenAnswer((_) async => tSuccessResult);

        final result = await useCase.call(1);

        expect(result.isSuccess, true);
        expect(result.data, tPostModel);
        verify(() => mockRepository.getPostById(1)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test("should pass different ids correctly", () async {
      when(
        () => mockRepository.getPostById(any()),
      ).thenAnswer((_) async => tSuccessResult);

      await useCase.call(42);

      verify(() => mockRepository.getPostById(42)).called(1);
    });
  });
}
