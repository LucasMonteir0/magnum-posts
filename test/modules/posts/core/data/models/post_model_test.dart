import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/posts/core/data/models/post_model.dart";
import "package:magnum_posts/modules/posts/core/domain/entities/post_entity.dart";

void main() {
  group("PostModel", () {
    const tId = 1;
    const tTitle = "Test Title";
    const tBody = "Test Body";
    const tUserId = 10;

    final tJsonMap = {
      "id": tId,
      "title": tTitle,
      "body": tBody,
      "userId": tUserId,
    };

    const tPostModel = PostModel(
      id: tId,
      title: tTitle,
      body: tBody,
      userId: tUserId,
    );

    test("should be a subclass of PostEntity", () {
      expect(tPostModel, isA<PostEntity>());
    });

    group("fromJson", () {
      test("should return a valid model when JSON is valid", () {
        final result = PostModel.fromJson(tJsonMap);

        expect(result.id, tId);
        expect(result.title, tTitle);
        expect(result.body, tBody);
        expect(result.userId, tUserId);
      });
    });

    group("toJson", () {
      test("should return a JSON map containing proper data", () {
        final result = tPostModel.toJson();

        expect(result, equals(tJsonMap));
      });
    });

    test("should support roundtrip serialization", () {
      final model = PostModel.fromJson(tJsonMap);
      final json = model.toJson();

      expect(json, equals(tJsonMap));
    });
  });
}
