import "package:fake_cloud_firestore/fake_cloud_firestore.dart";
import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/base_error.dart";
import "package:magnum_posts/modules/profile/core/data/datasources/profile_datasource_impl.dart";

void main() {
  late ProfileDataSourceImpl dataSource;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    dataSource = ProfileDataSourceImpl(fakeFirestore);
  });

  group("[DATA] ProfileDataSource", () {
    group("getProfile", () {
      const tUserId = "user-123";
      final tProfileData = {
        "id": tUserId,
        "name": "John Doe",
        "email": "john@example.com",
        "age": 25,
        "picture_url": "https://example.com/picture.jpg",
        "post_count": 10,
        "interests": ["Flutter", "Dart"],
      };

      test("getProfile - SUCCESS", () async {
        await fakeFirestore.collection("users").doc(tUserId).set(tProfileData);

        final result = await dataSource.getProfile(tUserId);

        expect(result.isSuccess, true);
        expect(result.data, isNotNull);
        expect(result.data!.id, tUserId);
        expect(result.data!.name, "John Doe");
        expect(result.data!.email, "john@example.com");
        expect(result.data!.age, 25);
        expect(result.data!.pictureUrl, "https://example.com/picture.jpg");
        expect(result.data!.postCount, 10);
        expect(result.data!.interests, ["Flutter", "Dart"]);
      });

      test("getProfile - ERROR", () async {
        final result = await dataSource.getProfile("non-existent-user");

        expect(result.isSuccess, false);
        expect(result.error, isA<BaseError>());
        expect(result.error!.message, "Usuário não encontrado");
      });
    });
  });
}
