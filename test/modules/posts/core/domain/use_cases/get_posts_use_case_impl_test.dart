import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:magnum_posts/modules/posts/core/data/models/post_model.dart";
import "package:magnum_posts/modules/posts/core/domain/repositories/posts_repository.dart";
import "package:magnum_posts/modules/posts/core/domain/use_cases/get_posts/get_posts_use_case.dart";
import "package:magnum_posts/modules/posts/core/domain/use_cases/get_posts/get_posts_use_case_impl.dart";
import "package:mocktail/mocktail.dart";

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  late GetPostsUseCase useCase;
  late MockPostsRepository mockRepository;

  setUp(() {
    mockRepository = MockPostsRepository();
    useCase = GetPostsUseCaseImpl(mockRepository);
  });

  group("[DOMAIN] GetPostsUseCase", () {
    final tPostsList = [
      const PostModel(id: 1, title: "Title 1", body: "Body 1", userId: 1),
      const PostModel(id: 2, title: "Title 2", body: "Body 2", userId: 2),
    ];

    test("When Repository Success", () async {
      final tSuccessResult = ResultWrapper.success(tPostsList);
      when(
        () => mockRepository.getPosts(),
      ).thenAnswer((_) async => tSuccessResult);

      final result = await useCase.call();

      expect(result.isSuccess, true);
      expect(result.data, tPostsList);
      verify(() => mockRepository.getPosts()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test("When Repository Error", () async {
      final tErrorResult = ResultWrapper<List<PostModel>>.error(
        BadRequestError(message: "Failed to get posts"),
      );
      when(
        () => mockRepository.getPosts(),
      ).thenAnswer((_) async => tErrorResult);

      final result = await useCase.call();

      expect(result.isSuccess, false);
      expect(result.error, isA<BadRequestError>());
      verify(() => mockRepository.getPosts()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
