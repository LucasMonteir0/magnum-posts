import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/auth/core/domain/repositories/auth_repository.dart";
import "package:magnum_posts/modules/auth/core/domain/use_cases/sign_out/sign_out_use_case_impl.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:mocktail/mocktail.dart";

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignOutUseCaseImpl useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignOutUseCaseImpl(mockRepository);
  });

  group("SignOutUseCaseImpl", () {
    test(
      "should delegate to repository.signOut() and return success result",
      () async {
        final tSuccessResult = ResultWrapper.success(true);
        when(
          () => mockRepository.signOut(),
        ).thenAnswer((_) async => tSuccessResult);

        final result = await useCase.call();

        expect(result.isSuccess, true);
        expect(result.data, true);
        verify(() => mockRepository.signOut()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      "should delegate to repository.signOut() and return error result",
      () async {
        final tErrorResult = ResultWrapper<bool>.error(
          UnknownError(message: "Sign out failed"),
        );
        when(
          () => mockRepository.signOut(),
        ).thenAnswer((_) async => tErrorResult);

        final result = await useCase.call();

        expect(result.isSuccess, false);
        expect(result.error, isA<UnknownError>());
        verify(() => mockRepository.signOut()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
