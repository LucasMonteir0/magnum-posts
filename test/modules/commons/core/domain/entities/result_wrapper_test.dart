import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";

void main() {
  group("ResultWrapper", () {
    group("success factory", () {
      test("should create a successful result with data", () {
        const tData = "Test Data";
        final result = ResultWrapper.success(tData);

        expect(result.isSuccess, true);
        expect(result.data, tData);
        expect(result.error, isNull);
      });

      test("should work with complex types", () {
        final tData = [1, 2, 3];
        final result = ResultWrapper.success(tData);

        expect(result.isSuccess, true);
        expect(result.data, [1, 2, 3]);
      });
    });

    group("error factory", () {
      test("should create a failed result with error", () {
        final tError = NotFoundError(message: "Not found");
        final result = ResultWrapper<String>.error(tError);

        expect(result.isSuccess, false);
        expect(result.data, isNull);
        expect(result.error, tError);
      });

      test("should handle null error", () {
        final result = ResultWrapper<String>.error(null);

        expect(result.isSuccess, false);
        expect(result.data, isNull);
        expect(result.error, isNull);
      });
    });

    test("should work with generic types", () {
      final intResult = ResultWrapper.success(42);
      final stringResult = ResultWrapper.success("Hello");
      final listResult = ResultWrapper.success([1, 2, 3]);

      expect(intResult.data, 42);
      expect(stringResult.data, "Hello");
      expect(listResult.data, [1, 2, 3]);
    });
  });
}
