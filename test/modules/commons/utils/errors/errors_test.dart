import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";

void main() {
  group("Error Classes", () {
    group("NotFoundError", () {
      test("should have correct default values", () {
        final error = NotFoundError();

        expect(error.code, 404);
        expect(error.message, "NotFoundError");
        expect(error.props, [error.message, error.code]);
      });

      test("should accept custom message", () {
        final error = NotFoundError(message: "Custom message");

        expect(error.message, "Custom message");
      });

      test("toString should return message", () {
        final error = NotFoundError(message: "Test");

        expect(error.toString(), "Test");
      });
    });

    group("ForBidenError", () {
      test("should have correct default values", () {
        final error = ForBidenError();

        expect(error.code, 403);
        expect(error.message, "ForBidenError");
      });
    });

    group("BadRequestError", () {
      test("should have correct default values", () {
        final error = BadRequestError();

        expect(error.code, 400);
        expect(error.message, "BadRequestError");
      });
    });

    group("UnauthorizedError", () {
      test("should have correct default values", () {
        final error = UnauthorizedError();

        expect(error.code, 401);
        expect(error.message, "UnauthorizedError");
      });
    });

    group("InternalServerError", () {
      test("should have correct default values", () {
        final error = InternalServerError();

        expect(error.code, 500);
        expect(error.message, "InternalServerError");
      });
    });

    group("ServiceUnavailableError", () {
      test("should have correct default values", () {
        final error = ServiceUnavailableError();

        expect(error.code, 503);
        expect(error.message, "ServiceUnavailableError");
      });
    });

    group("ConflictError", () {
      test("should have correct default values", () {
        final error = ConflictError();

        expect(error.code, 409);
        expect(error.message, "ConflictError");
      });
    });

    group("UnProcessableEntityError", () {
      test("should have correct default values", () {
        final error = UnProcessableEntityError();

        expect(error.code, 422);
        expect(error.message, "UnProcessableEntityError");
      });
    });

    group("TooManyRequestsError", () {
      test("should have correct default values", () {
        final error = TooManyRequestsError();

        expect(error.code, 429);
        expect(error.message, "TooManyRequestsError");
      });
    });

    group("UnknownError", () {
      test("should have correct default values", () {
        final error = UnknownError();

        expect(error.code, -1);
        expect(error.message, "Ocorreu um erro");
      });
    });

    group("Equatable", () {
      test("errors with same values should be equal", () {
        final error1 = NotFoundError(message: "Test");
        final error2 = NotFoundError(message: "Test");

        expect(error1, equals(error2));
      });

      test("errors with different values should not be equal", () {
        final error1 = NotFoundError(message: "Test1");
        final error2 = NotFoundError(message: "Test2");

        expect(error1, isNot(equals(error2)));
      });
    });
  });
}
