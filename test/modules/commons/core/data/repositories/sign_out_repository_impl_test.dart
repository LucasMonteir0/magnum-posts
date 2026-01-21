import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/core/data/datasources/sign_out_datasource.dart";
import "package:magnum_posts/modules/commons/core/data/repositories/sign_out_repository_impl.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:mocktail/mocktail.dart";

class MockSignOutDataSource extends Mock implements SignOutDataSource {}

void main() {
  late SignOutRepositoryImpl repository;
  late MockSignOutDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockSignOutDataSource();
    repository = SignOutRepositoryImpl(mockDataSource);
  });

  group("SignOutRepositoryImpl", () {
    group("signOut", () {
      test(
        "should delegate to dataSource.signOut() and return success result",
        () async {
          final tSuccessResult = ResultWrapper.success(true);
          when(
            () => mockDataSource.signOut(),
          ).thenAnswer((_) async => tSuccessResult);

          final result = await repository.signOut();

          expect(result.isSuccess, true);
          expect(result.data, true);
          verify(() => mockDataSource.signOut()).called(1);
          verifyNoMoreInteractions(mockDataSource);
        },
      );

      test(
        "should delegate to dataSource.signOut() and return error result",
        () async {
          final tErrorResult = ResultWrapper<bool>.error(
            UnknownError(message: "Sign out failed"),
          );
          when(
            () => mockDataSource.signOut(),
          ).thenAnswer((_) async => tErrorResult);

          final result = await repository.signOut();

          expect(result.isSuccess, false);
          expect(result.error, isA<UnknownError>());
          verify(() => mockDataSource.signOut()).called(1);
          verifyNoMoreInteractions(mockDataSource);
        },
      );
    });
  });
}
