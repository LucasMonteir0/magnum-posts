import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:magnum_posts/modules/profile/core/data/models/profile_model.dart";
import "package:magnum_posts/modules/profile/core/domain/repositories/profile_repository.dart";
import "package:magnum_posts/modules/profile/core/domain/user_cases/get_profile/get_profile_use_case_impl.dart";
import "package:mocktail/mocktail.dart";

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late GetProfileUseCaseImpl useCase;
  late MockProfileRepository mockRepository;

  setUp(() {
    mockRepository = MockProfileRepository();
    useCase = GetProfileUseCaseImpl(mockRepository);
  });

  group("[DOMAIN] GetProfileUseCase", () {
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

    test("When Repository Success", () async {
      when(
        () => mockRepository.getProfile(any()),
      ).thenAnswer((_) async => tSuccessResult);

      final result = await useCase.call(tUserId);

      expect(result.isSuccess, true);
      expect(result.data, tProfileModel);
      verify(() => mockRepository.getProfile(tUserId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test("When Repository Error", () async {
      when(
        () => mockRepository.getProfile(any()),
      ).thenAnswer((_) async => tErrorResult);

      final result = await useCase.call(tUserId);

      expect(result.isSuccess, false);
      expect(result.error, isA<NotFoundError>());
      verify(() => mockRepository.getProfile(tUserId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
