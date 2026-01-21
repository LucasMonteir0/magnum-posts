import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/profile/core/data/models/profile_model.dart";

void main() {
  group("ProfileModel", () {
    const tId = "user-123";
    const tName = "John Doe";
    const tEmail = "john@example.com";
    const tAge = 25;
    const tPictureUrl = "https://example.com/picture.jpg";
    const tPostCount = 10;
    const tInterests = ["Flutter", "Dart", "Mobile"];

    final tProfileModel = ProfileModel(
      id: tId,
      name: tName,
      email: tEmail,
      age: tAge,
      pictureUrl: tPictureUrl,
      postCount: tPostCount,
      interests: tInterests,
    );

    final tJson = {
      "id": tId,
      "name": tName,
      "email": tEmail,
      "age": tAge,
      "picture_url": tPictureUrl,
      "post_count": tPostCount,
      "interests": tInterests,
    };

    group("fromJson", () {
      test("should return a valid ProfileModel from JSON", () {
        final result = ProfileModel.fromJson(tJson);

        expect(result.id, tId);
        expect(result.name, tName);
        expect(result.email, tEmail);
        expect(result.age, tAge);
        expect(result.pictureUrl, tPictureUrl);
        expect(result.postCount, tPostCount);
        expect(result.interests, tInterests);
      });

      test("should correctly parse interests list", () {
        final result = ProfileModel.fromJson(tJson);

        expect(result.interests, isA<List<String>>());
        expect(result.interests.length, 3);
        expect(result.interests[0], "Flutter");
      });
    });

    group("toJson", () {
      test("should return a valid JSON map from ProfileModel", () {
        final result = tProfileModel.toJson();

        expect(result["id"], tId);
        expect(result["name"], tName);
        expect(result["email"], tEmail);
        expect(result["age"], tAge);
        expect(result["picture_url"], tPictureUrl);
        expect(result["post_count"], tPostCount);
        expect(result["interests"], tInterests);
      });

      test("toJson and fromJson should be symmetric", () {
        final json = tProfileModel.toJson();
        final result = ProfileModel.fromJson(json);

        expect(result.id, tProfileModel.id);
        expect(result.name, tProfileModel.name);
        expect(result.email, tProfileModel.email);
        expect(result.age, tProfileModel.age);
        expect(result.pictureUrl, tProfileModel.pictureUrl);
        expect(result.postCount, tProfileModel.postCount);
        expect(result.interests, tProfileModel.interests);
      });
    });
  });
}
