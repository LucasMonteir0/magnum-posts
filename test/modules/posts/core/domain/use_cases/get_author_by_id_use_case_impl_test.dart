import 'package:flutter_test/flutter_test.dart';
import 'package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart';
import 'package:magnum_posts/modules/posts/core/data/models/author_model.dart';
import 'package:magnum_posts/modules/posts/core/domain/repositories/posts_repository.dart';
import 'package:magnum_posts/modules/posts/core/domain/use_cases/get_author_by_id/get_author_by_id_use_case_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  late GetAuthorByIdUseCaseImpl useCase;
  late MockPostsRepository mockRepository;

  setUp(() {
    mockRepository = MockPostsRepository();
    useCase = GetAuthorByIdUseCaseImpl(mockRepository);
  });

  group('GetAuthorByIdUseCaseImpl', () {
    const tAuthorModel = AuthorModel(id: 1, name: 'John Doe');
    final tSuccessResult = ResultWrapper.success(tAuthorModel);

    test(
      'should delegate to repository.getAuthorById() with correct id',
      () async {
        when(
          () => mockRepository.getAuthorById(any()),
        ).thenAnswer((_) async => tSuccessResult);

        final result = await useCase.call(1);

        expect(result.isSuccess, true);
        expect(result.data, tAuthorModel);
        verify(() => mockRepository.getAuthorById(1)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should pass different ids correctly', () async {
      when(
        () => mockRepository.getAuthorById(any()),
      ).thenAnswer((_) async => tSuccessResult);

      await useCase.call(99);

      verify(() => mockRepository.getAuthorById(99)).called(1);
    });
  });
}
