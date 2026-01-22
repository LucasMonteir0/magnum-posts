import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/auth/core/data/datarources/auth_datasource.dart";
import "package:magnum_posts/modules/auth/core/data/datarources/auth_datasource_impl.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:mocktail/mocktail.dart";

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late AuthDataSource dataSource;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    dataSource = AuthDataSourceImpl(mockFirebaseAuth);
  });

  group("[DATA] - AuthDataSource", () {
    group("signIn", () {
      const tEmail = "test@example.com";
      const tPassword = "password123";
      const tUserId = "123456";

      test("signIn - SUCCESS", () async {
        final mockUserCredential = MockUserCredential();
        final mockUser = MockUser();

        when(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: any(named: "email"),
            password: any(named: "password"),
          ),
        ).thenAnswer((_) async => mockUserCredential);

        when(() => mockUserCredential.user).thenReturn(mockUser);
        when(() => mockUser.uid).thenReturn(tUserId);

        final result = await dataSource.signIn(tEmail, tPassword);

        expect(result.isSuccess, true);
        expect(result.data, tUserId);
        verify(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
      });

      test("signIn - ERROR - From Firebase", () async {
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

        final result = await dataSource.signIn(tEmail, tPassword);

        expect(result.isSuccess, false);
        expect(result.error, isNotNull);
        expect(result.error, isA<BadRequestError>());
      });

      test("signIn - ERROR - Unknown", () async {
        when(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: any(named: "email"),
            password: any(named: "password"),
          ),
        ).thenThrow(Exception("Unknown error"));

        final result = await dataSource.signIn(tEmail, tPassword);

        expect(result.isSuccess, false);
        expect(result.error, isNotNull);
        expect(result.error, isA<UnknownError>());
      });
    });
  });
}
