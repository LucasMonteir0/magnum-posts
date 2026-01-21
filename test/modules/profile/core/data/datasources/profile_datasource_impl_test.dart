import "package:fake_cloud_firestore/fake_cloud_firestore.dart";
import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:magnum_posts/modules/profile/core/data/datasources/profile_datasource_impl.dart";

void main() {
  late ProfileDataSourceImpl dataSource;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    dataSource = ProfileDataSourceImpl(fakeFirestore);
  });

  group("ProfileDataSourceImpl", () {
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

      test(
        "should return ProfileEntity when document exists with valid data",
        () async {
          await fakeFirestore
              .collection("users")
              .doc(tUserId)
              .set(tProfileData);

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
        },
      );

      test(
        "should return NotFoundError when document does not exist",
        () async {
          final result = await dataSource.getProfile("non-existent-user");

          expect(result.isSuccess, false);
          expect(result.error, isA<NotFoundError>());
          expect(result.error!.message, "Usuário não encontrado");
        },
      );

      test("should correctly parse interests list from Firestore", () async {
        final dataWithMultipleInterests = {
          ...tProfileData,
          "interests": ["Flutter", "Dart", "Firebase", "Mobile"],
        };
        await fakeFirestore
            .collection("users")
            .doc(tUserId)
            .set(dataWithMultipleInterests);

        final result = await dataSource.getProfile(tUserId);

        expect(result.isSuccess, true);
        expect(result.data!.interests.length, 4);
        expect(result.data!.interests, contains("Firebase"));
      });

      test("should handle empty interests list", () async {
        final dataWithEmptyInterests = {
          ...tProfileData,
          "interests": <String>[],
        };
        await fakeFirestore
            .collection("users")
            .doc(tUserId)
            .set(dataWithEmptyInterests);

        final result = await dataSource.getProfile(tUserId);

        expect(result.isSuccess, true);
        expect(result.data!.interests, isEmpty);
      });

      test("should return correct profile for different users", () async {
        const anotherUserId = "user-456";
        final anotherProfileData = {
          "id": anotherUserId,
          "name": "Jane Smith",
          "email": "jane@example.com",
          "age": 30,
          "picture_url": "https://example.com/jane.jpg",
          "post_count": 5,
          "interests": ["Design"],
        };

        await fakeFirestore.collection("users").doc(tUserId).set(tProfileData);
        await fakeFirestore
            .collection("users")
            .doc(anotherUserId)
            .set(anotherProfileData);

        final result1 = await dataSource.getProfile(tUserId);
        final result2 = await dataSource.getProfile(anotherUserId);

        expect(result1.data!.name, "John Doe");
        expect(result2.data!.name, "Jane Smith");
      });
    });
  });
}
