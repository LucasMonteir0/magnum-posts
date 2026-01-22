import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:magnum_posts/modules/profile/core/data/datasources/profile_datasource.dart";
import "package:magnum_posts/modules/profile/core/data/models/profile_model.dart";
import "package:magnum_posts/modules/profile/core/data/repositories/profile_repository_impl.dart";
import "package:mocktail/mocktail.dart";

class MockProfileDataSource extends Mock implements ProfileDataSource {}

void main() {
  late ProfileRepositoryImpl repository;
  late MockProfileDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockProfileDataSource();
    repository = ProfileRepositoryImpl(mockDataSource);
  });

  group("[DATA] ProfileRepository", () {
    group("getProfile", () {
      const tUserId = "user-123";
      final tProfileModel = ProfileModel(
        id: tUserId,
        name: "John Doe",
        email: "john@example.com",
        age: 25,
        pictureUrl: "https://example.com/picture.jpg",
        postCount: 10,
        interests: ["Flutter", "Dart"],
      );
      final tSuccessResult = ResultWrapper.success(tProfileModel);
      final tErrorResult = ResultWrapper<ProfileModel>.error(
        NotFoundError(message: "Usuário não encontrado"),
      );

      test("When Datasource Success", () async {
        when(
          () => mockDataSource.getProfile(any()),
        ).thenAnswer((_) async => tSuccessResult);

        final result = await repository.getProfile(tUserId);

        expect(result.isSuccess, true);
        expect(result.data, tProfileModel);
        verify(() => mockDataSource.getProfile(tUserId)).called(1);
        verifyNoMoreInteractions(mockDataSource);
      });

      test("When Datasource Error", () async {
        when(
          () => mockDataSource.getProfile(any()),
        ).thenAnswer((_) async => tErrorResult);

        final result = await repository.getProfile(tUserId);

        expect(result.isSuccess, false);
        expect(result.error, isA<NotFoundError>());
        verify(() => mockDataSource.getProfile(tUserId)).called(1);
        verifyNoMoreInteractions(mockDataSource);
      });
    });
  });
}
