import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/auth/core/data/datarources/auth_datasource.dart";
import "package:magnum_posts/modules/auth/core/data/repositories/auth_repository_impl.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:mocktail/mocktail.dart";

class MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockAuthDataSource();
    repository = AuthRepositoryImpl(mockDataSource);
  });

  group("AuthRepositoryImpl", () {
    group("signIn", () {
      const tEmail = "test@example.com";
      const tPassword = "password123";
      const tUserId = "123456";

      test(
        "should delegate to dataSource.signIn() and return success result",
        () async {
          final tSuccessResult = ResultWrapper.success(tUserId);
          when(
            () => mockDataSource.signIn(any(), any()),
          ).thenAnswer((_) async => tSuccessResult);

          final result = await repository.signIn(tEmail, tPassword);

          expect(result.isSuccess, true);
          expect(result.data, tUserId);
          verify(() => mockDataSource.signIn(tEmail, tPassword)).called(1);
          verifyNoMoreInteractions(mockDataSource);
        },
      );

      test(
        "should delegate to dataSource.signIn() and return error result",
        () async {
          final tErrorResult = ResultWrapper<String>.error(
            BadRequestError(message: "Invalid credentials"),
          );
          when(
            () => mockDataSource.signIn(any(), any()),
          ).thenAnswer((_) async => tErrorResult);

          final result = await repository.signIn(tEmail, tPassword);

          expect(result.isSuccess, false);
          expect(result.error, isA<BadRequestError>());
          verify(() => mockDataSource.signIn(tEmail, tPassword)).called(1);
          verifyNoMoreInteractions(mockDataSource);
        },
      );

      test("should pass correct email and password to dataSource", () async {
        final tSuccessResult = ResultWrapper.success(tUserId);
        when(
          () => mockDataSource.signIn(any(), any()),
        ).thenAnswer((_) async => tSuccessResult);

        await repository.signIn(tEmail, tPassword);

        verify(() => mockDataSource.signIn(tEmail, tPassword)).called(1);
      });
    });
  });
}
