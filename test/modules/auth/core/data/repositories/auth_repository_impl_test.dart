import 'package:flutter_test/flutter_test.dart';
import 'package:magnum_posts/modules/auth/core/data/datarources/auth_datasource.dart';
import 'package:magnum_posts/modules/auth/core/data/repositories/auth_repository_impl.dart';
import 'package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart';
import 'package:magnum_posts/modules/commons/utils/errors/errors.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockAuthDataSource();
    repository = AuthRepositoryImpl(mockDataSource);
  });

  group('AuthRepositoryImpl', () {
    group('signIn', () {
      const tEmail = 'test@example.com';
      const tPassword = 'password123';

      test(
        'should delegate to dataSource.signIn() and return success result',
        () async {
          // Arrange
          final tSuccessResult = ResultWrapper.success(true);
          when(
            () => mockDataSource.signIn(any(), any()),
          ).thenAnswer((_) async => tSuccessResult);

          // Act
          final result = await repository.signIn(tEmail, tPassword);

          // Assert
          expect(result.isSuccess, true);
          expect(result.data, true);
          verify(() => mockDataSource.signIn(tEmail, tPassword)).called(1);
          verifyNoMoreInteractions(mockDataSource);
        },
      );

      test(
        'should delegate to dataSource.signIn() and return error result',
        () async {
          // Arrange
          final tErrorResult = ResultWrapper<bool>.error(
            BadRequestError(message: 'Invalid credentials'),
          );
          when(
            () => mockDataSource.signIn(any(), any()),
          ).thenAnswer((_) async => tErrorResult);

          // Act
          final result = await repository.signIn(tEmail, tPassword);

          // Assert
          expect(result.isSuccess, false);
          expect(result.error, isA<BadRequestError>());
          verify(() => mockDataSource.signIn(tEmail, tPassword)).called(1);
          verifyNoMoreInteractions(mockDataSource);
        },
      );

      test('should pass correct email and password to dataSource', () async {
        // Arrange
        final tSuccessResult = ResultWrapper.success(true);
        when(
          () => mockDataSource.signIn(any(), any()),
        ).thenAnswer((_) async => tSuccessResult);

        // Act
        await repository.signIn(tEmail, tPassword);

        // Assert
        verify(() => mockDataSource.signIn(tEmail, tPassword)).called(1);
      });
    });
  });
}
