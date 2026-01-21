import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/posts/core/data/models/author_model.dart";
import "package:magnum_posts/modules/posts/core/domain/entities/author_entity.dart";

void main() {
  group("AuthorModel", () {
    const tId = 1;
    const tName = "John Doe";

    final tJsonMap = {"id": tId, "name": tName};

    const tAuthorModel = AuthorModel(id: tId, name: tName);

    test("should be a subclass of AuthorEntity", () {
      expect(tAuthorModel, isA<AuthorEntity>());
    });

    group("fromJson", () {
      test("should return a valid model when JSON is valid", () {
        final result = AuthorModel.fromJson(tJsonMap);

        expect(result.id, tId);
        expect(result.name, tName);
      });
    });

    group("toJson", () {
      test("should return a JSON map containing proper data", () {
        final result = tAuthorModel.toJson();

        expect(result, equals(tJsonMap));
      });
    });

    test("should support roundtrip serialization", () {
      final model = AuthorModel.fromJson(tJsonMap);
      final json = model.toJson();

      expect(json, equals(tJsonMap));
    });
  });
}
