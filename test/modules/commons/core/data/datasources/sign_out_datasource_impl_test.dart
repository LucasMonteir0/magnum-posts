import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/core/data/datasources/sign_out_datasource.dart";
import "package:magnum_posts/modules/commons/core/data/datasources/sign_out_datasource_impl.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:mocktail/mocktail.dart";

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late SignOutDataSource dataSource;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    dataSource = SignOutDataSourceImpl(mockFirebaseAuth);
  });

  group("[DATA] SignOutDataSource", () {
    group("signOut", () {
      test("signOut - SUCCESS", () async {
        when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {});

        final result = await dataSource.signOut();

        expect(result.isSuccess, true);
        expect(result.data, true);
        verify(() => mockFirebaseAuth.signOut()).called(1);
      });

      test("signOut - ERROR - From Firebase", () async {
        when(() => mockFirebaseAuth.signOut()).thenThrow(
          FirebaseAuthException(
            code: "user-token-expired",
            message: "Token expired",
          ),
        );

        final result = await dataSource.signOut();

        expect(result.isSuccess, false);
        expect(result.error, isNotNull);
      });

      test("signOut - ERROR - Unknown Error", () async {
        when(
          () => mockFirebaseAuth.signOut(),
        ).thenThrow(Exception("Unknown error"));

        final result = await dataSource.signOut();

        expect(result.isSuccess, false);
        expect(result.error, isA<UnknownError>());
      });
    });
  });
}
