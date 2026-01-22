import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:magnum_posts/modules/posts/core/data/models/author_model.dart";
import "package:magnum_posts/modules/posts/core/domain/repositories/posts_repository.dart";
import "package:magnum_posts/modules/posts/core/domain/use_cases/get_author_by_id/get_author_by_id_use_case.dart";
import "package:magnum_posts/modules/posts/core/domain/use_cases/get_author_by_id/get_author_by_id_use_case_impl.dart";
import "package:mocktail/mocktail.dart";

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  late GetAuthorByIdUseCase useCase;
  late MockPostsRepository mockRepository;

  setUp(() {
    mockRepository = MockPostsRepository();
    useCase = GetAuthorByIdUseCaseImpl(mockRepository);
  });

  group("[DOMAIN] GetAuthorByIdUseCase", () {
    const tAuthorModel = AuthorModel(id: 1, name: "John Doe");

    test("When Repository Success", () async {
      final tSuccessResult = ResultWrapper.success(tAuthorModel);
      when(
        () => mockRepository.getAuthorById(any()),
      ).thenAnswer((_) async => tSuccessResult);

      final result = await useCase.call(1);

      expect(result.isSuccess, true);
      expect(result.data, tAuthorModel);
      verify(() => mockRepository.getAuthorById(1)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test("When Repository Error", () async {
      final tErrorResult = ResultWrapper<AuthorModel>.error(
        BadRequestError(message: "Author not found"),
      );
      when(
        () => mockRepository.getAuthorById(any()),
      ).thenAnswer((_) async => tErrorResult);

      final result = await useCase.call(1);

      expect(result.isSuccess, false);
      expect(result.error, isA<BadRequestError>());
      verify(() => mockRepository.getAuthorById(1)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
