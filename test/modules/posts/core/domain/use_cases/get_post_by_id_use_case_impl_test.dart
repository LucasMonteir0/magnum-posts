import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:magnum_posts/modules/posts/core/data/models/post_model.dart";
import "package:magnum_posts/modules/posts/core/domain/repositories/posts_repository.dart";
import "package:magnum_posts/modules/posts/core/domain/use_cases/get_post_by_id/get_post_by_id_use_case.dart";
import "package:magnum_posts/modules/posts/core/domain/use_cases/get_post_by_id/get_post_by_id_use_case_impl.dart";
import "package:mocktail/mocktail.dart";

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  late GetPostByIdUseCase useCase;
  late MockPostsRepository mockRepository;

  setUp(() {
    mockRepository = MockPostsRepository();
    useCase = GetPostByIdUseCaseImpl(mockRepository);
  });

  group("[DOMAIN] GetPostByIdUseCase", () {
    const tPostModel = PostModel(
      id: 1,
      title: "Title",
      body: "Body",
      userId: 1,
    );

    test("When Repository Success", () async {
      final tSuccessResult = ResultWrapper.success(tPostModel);
      when(
        () => mockRepository.getPostById(any()),
      ).thenAnswer((_) async => tSuccessResult);

      final result = await useCase.call(1);

      expect(result.isSuccess, true);
      expect(result.data, tPostModel);
      verify(() => mockRepository.getPostById(1)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test("When Repository Error", () async {
      final tErrorResult = ResultWrapper<PostModel>.error(
        BadRequestError(message: "Post not found"),
      );
      when(
        () => mockRepository.getPostById(any()),
      ).thenAnswer((_) async => tErrorResult);

      final result = await useCase.call(1);

      expect(result.isSuccess, false);
      expect(result.error, isA<BadRequestError>());
      verify(() => mockRepository.getPostById(1)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
