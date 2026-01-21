import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/auth/core/domain/repositories/auth_repository.dart";
import "package:magnum_posts/modules/auth/core/domain/use_cases/sign_in/sign_in_use_case_impl.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:mocktail/mocktail.dart";

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignInUseCaseImpl useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignInUseCaseImpl(mockRepository);
  });

  group("SignInUseCaseImpl", () {
    const tEmail = "test@example.com";
    const tPassword = "password123";

    test(
      "should delegate to repository.signIn() and return success result",
      () async {
        final tSuccessResult = ResultWrapper.success(true);
        when(
          () => mockRepository.signIn(any(), any()),
        ).thenAnswer((_) async => tSuccessResult);

        final result = await useCase.call(tEmail, tPassword);

        expect(result.isSuccess, true);
        expect(result.data, true);
        verify(() => mockRepository.signIn(tEmail, tPassword)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      "should delegate to repository.signIn() and return error result",
      () async {
        final tErrorResult = ResultWrapper<bool>.error(
          BadRequestError(message: "Invalid credentials"),
        );
        when(
          () => mockRepository.signIn(any(), any()),
        ).thenAnswer((_) async => tErrorResult);

        final result = await useCase.call(tEmail, tPassword);

        expect(result.isSuccess, false);
        expect(result.error, isA<BadRequestError>());
        verify(() => mockRepository.signIn(tEmail, tPassword)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test("should pass correct email and password to repository", () async {
      final tSuccessResult = ResultWrapper.success(true);
      when(
        () => mockRepository.signIn(any(), any()),
      ).thenAnswer((_) async => tSuccessResult);

      await useCase.call(tEmail, tPassword);

      verify(() => mockRepository.signIn(tEmail, tPassword)).called(1);
    });
  });
}
