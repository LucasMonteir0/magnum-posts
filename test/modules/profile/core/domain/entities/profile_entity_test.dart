import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/profile/core/domain/entites/profile_entity.dart";

void main() {
  group("ProfileEntity", () {
    test("should create ProfileEntity with all required fields", () {
      final entity = ProfileEntity(
        id: "user-123",
        name: "John Doe",
        email: "john@example.com",
        age: 25,
        pictureUrl: "https://example.com/picture.jpg",
        postCount: 10,
        interests: ["Flutter", "Dart"],
      );

      expect(entity.id, "user-123");
      expect(entity.name, "John Doe");
      expect(entity.email, "john@example.com");
      expect(entity.age, 25);
      expect(entity.pictureUrl, "https://example.com/picture.jpg");
      expect(entity.postCount, 10);
      expect(entity.interests, ["Flutter", "Dart"]);
    });

    test("should allow empty interests list", () {
      final entity = ProfileEntity(
        id: "user-123",
        name: "John Doe",
        email: "john@example.com",
        age: 25,
        pictureUrl: "https://example.com/picture.jpg",
        postCount: 0,
        interests: [],
      );

      expect(entity.interests, isEmpty);
    });
  });
}
