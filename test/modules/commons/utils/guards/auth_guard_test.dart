import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_modular/flutter_modular.dart";
import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/utils/config/routes.dart";
import "package:magnum_posts/modules/commons/utils/guards/auth_guard.dart";
import "package:mocktail/mocktail.dart";

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockParallelRoute extends Mock implements ParallelRoute {}

class TestModule extends Module {
  final FirebaseAuth firebaseAuth;

  TestModule(this.firebaseAuth);

  @override
  List<Bind> get binds => [Bind.instance<FirebaseAuth>(firebaseAuth)];
}

void main() {
  late AuthGuard authGuard;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockParallelRoute mockRoute;

  setUpAll(() {
    mockFirebaseAuth = MockFirebaseAuth();
    Modular.init(TestModule(mockFirebaseAuth));
  });

  setUp(() {
    mockRoute = MockParallelRoute();
    reset(mockFirebaseAuth);
    authGuard = AuthGuard();
  });

  group("AuthGuard", () {
    test("should have correct redirectTo path", () {
      expect(authGuard.redirectTo, Routes.auth + Routes.signIn);
    });

    test("should return true when user is authenticated", () async {
      final mockUser = MockUser();
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);

      final result = await authGuard.canActivate("/test", mockRoute);

      expect(result, true);
      verify(() => mockFirebaseAuth.currentUser).called(1);
    });

    test("should return false when user is not authenticated", () async {
      when(() => mockFirebaseAuth.currentUser).thenReturn(null);

      final result = await authGuard.canActivate("/test", mockRoute);

      expect(result, false);
      verify(() => mockFirebaseAuth.currentUser).called(1);
    });
  });
}
