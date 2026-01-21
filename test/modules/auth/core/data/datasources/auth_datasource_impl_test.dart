import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/auth/core/data/datarources/auth_datasource_impl.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:mocktail/mocktail.dart";

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late AuthDataSourceImpl dataSource;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    dataSource = AuthDataSourceImpl(mockFirebaseAuth);
  });

  group("AuthDataSourceImpl", () {
    group("signIn", () {
      const tEmail = "test@example.com";
      const tPassword = "password123";

      test(
        "should return ResultWrapper.success(true) when signIn is successful and user is not null",
        () async {
          // Arrange
          final mockUserCredential = MockUserCredential();
          final mockUser = MockUser();

          when(
            () => mockFirebaseAuth.signInWithEmailAndPassword(
              email: any(named: "email"),
              password: any(named: "password"),
            ),
          ).thenAnswer((_) async => mockUserCredential);

          when(() => mockUserCredential.user).thenReturn(mockUser);

          // Act
          final result = await dataSource.signIn(tEmail, tPassword);

          // Assert
          expect(result.isSuccess, true);
          expect(result.data, true);
          verify(
            () => mockFirebaseAuth.signInWithEmailAndPassword(
              email: tEmail,
              password: tPassword,
            ),
          ).called(1);
        },
      );

      test(
        "should return ResultWrapper.success(false) when signIn is successful but user is null",
        () async {
          // Arrange
          final mockUserCredential = MockUserCredential();

          when(
            () => mockFirebaseAuth.signInWithEmailAndPassword(
              email: any(named: "email"),
              password: any(named: "password"),
            ),
          ).thenAnswer((_) async => mockUserCredential);

          when(() => mockUserCredential.user).thenReturn(null);

          // Act
          final result = await dataSource.signIn(tEmail, tPassword);

          // Assert
          expect(result.isSuccess, true);
          expect(result.data, false);
        },
      );

      test(
        "should return ResultWrapper.error with handled error when FirebaseAuthException is thrown",
        () async {
          // Arrange
          when(
            () => mockFirebaseAuth.signInWithEmailAndPassword(
              email: any(named: "email"),
              password: any(named: "password"),
            ),
          ).thenThrow(
            FirebaseAuthException(
              code: "user-not-found",
              message: "User not found",
            ),
          );

          // Act
          final result = await dataSource.signIn(tEmail, tPassword);

          // Assert
          expect(result.isSuccess, false);
          expect(result.error, isNotNull);
          expect(result.error, isA<BadRequestError>());
        },
      );

      test(
        "should return ResultWrapper.error with UnknownError when generic exception is thrown",
        () async {
          // Arrange
          when(
            () => mockFirebaseAuth.signInWithEmailAndPassword(
              email: any(named: "email"),
              password: any(named: "password"),
            ),
          ).thenThrow(Exception("Unknown error"));

          // Act
          final result = await dataSource.signIn(tEmail, tPassword);

          // Assert
          expect(result.isSuccess, false);
          expect(result.error, isNotNull);
          expect(result.error, isA<UnknownError>());
        },
      );
    });
  });
}
