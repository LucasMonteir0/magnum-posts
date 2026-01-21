import "package:dio/dio.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:magnum_posts/modules/commons/utils/errors/handle_firebase_errors.dart";

void main() {
  group("handleFirebaseError", () {
    group("FirebaseException handling", () {
      test("should return BadRequestError for user-not-found", () {
        final error = FirebaseException(
          plugin: "firebase_auth",
          code: "user-not-found",
          message: "User not found",
        );

        final result = handleFirebaseError(error);

        expect(result, isA<BadRequestError>());
        expect(result.message, "Email ou senha incorrentos");
      });

      test("should return BadRequestError for wrong-password", () {
        final error = FirebaseException(
          plugin: "firebase_auth",
          code: "wrong-password",
          message: "Wrong password",
        );

        final result = handleFirebaseError(error);

        expect(result, isA<BadRequestError>());
        expect(result.message, "Email ou senha incorrentos");
      });

      test("should return BadRequestError for invalid-email", () {
        final error = FirebaseException(
          plugin: "firebase_auth",
          code: "invalid-email",
          message: "Invalid email",
        );

        final result = handleFirebaseError(error);

        expect(result, isA<BadRequestError>());
        expect(result.message, "Email ou senha incorrentos");
      });

      test("should return BadRequestError for invalid-credential", () {
        final error = FirebaseException(
          plugin: "firebase_auth",
          code: "invalid-credential",
          message: "Invalid credential",
        );

        final result = handleFirebaseError(error);

        expect(result, isA<BadRequestError>());
        expect(result.message, "Email ou senha incorrentos");
      });

      test("should return ForBidenError for user-token-expired", () {
        final error = FirebaseException(
          plugin: "firebase_auth",
          code: "user-token-expired",
          message: "Token expired",
        );

        final result = handleFirebaseError(error);

        expect(result, isA<ForBidenError>());
        expect(result.message, "É necessário fazer o login");
      });

      test("should return ForBidenError for user-disabled", () {
        final error = FirebaseException(
          plugin: "firebase_auth",
          code: "user-disabled",
          message: "User disabled",
        );

        final result = handleFirebaseError(error);

        expect(result, isA<ForBidenError>());
        expect(result.message, "Usuário desativado");
      });

      test("should return ConflictError for email-already-in-use", () {
        final error = FirebaseException(
          plugin: "firebase_auth",
          code: "email-already-in-use",
          message: "Email already in use",
        );

        final result = handleFirebaseError(error);

        expect(result, isA<ConflictError>());
        expect(result.message, "Email já cadastrado");
      });

      test("should return TooManyRequestsError for too-many-requests", () {
        final error = FirebaseException(
          plugin: "firebase_auth",
          code: "too-many-requests",
          message: "Too many requests",
        );

        final result = handleFirebaseError(error);

        expect(result, isA<TooManyRequestsError>());
        expect(result.message, "Espere alguns minutos e tente novamente");
      });

      test("should return BadGatewayError for network-request-failed", () {
        final error = FirebaseException(
          plugin: "firebase_auth",
          code: "network-request-failed",
          message: "Network request failed",
        );

        final result = handleFirebaseError(error);

        expect(result, isA<BadGatewayError>());
        expect(result.message, "Você não está conectado à internet");
      });

      test("should return ForBidenError for operation-not-allowed", () {
        final error = FirebaseException(
          plugin: "firebase_auth",
          code: "operation-not-allowed",
          message: "Operation not allowed",
        );

        final result = handleFirebaseError(error, message: "Custom message");

        expect(result, isA<ForBidenError>());
        expect(result.message, "Custom message");
      });

      test("should return UnknownError for unknown Firebase error code", () {
        final error = FirebaseException(
          plugin: "firebase_auth",
          code: "unknown-error-code",
          message: "Unknown error",
        );

        final result = handleFirebaseError(error);

        expect(result, isA<UnknownError>());
      });
    });

    group("DioException handling", () {
      test("should return appropriate error for DioException with 404", () {
        final error = DioException(
          requestOptions: RequestOptions(path: "/test"),
          response: Response(
            requestOptions: RequestOptions(path: "/test"),
            statusCode: 404,
          ),
          type: DioExceptionType.badResponse,
        );

        final result = handleFirebaseError(error);

        expect(result, isA<NotFoundError>());
      });

      test("should return appropriate error for DioException with 401", () {
        final error = DioException(
          requestOptions: RequestOptions(path: "/test"),
          response: Response(
            requestOptions: RequestOptions(path: "/test"),
            statusCode: 401,
          ),
          type: DioExceptionType.badResponse,
        );

        final result = handleFirebaseError(error);

        expect(result, isA<UnauthorizedError>());
      });

      test("should return appropriate error for DioException with 500", () {
        final error = DioException(
          requestOptions: RequestOptions(path: "/test"),
          response: Response(
            requestOptions: RequestOptions(path: "/test"),
            statusCode: 500,
          ),
          type: DioExceptionType.badResponse,
        );

        final result = handleFirebaseError(error);

        expect(result, isA<InternalServerError>());
      });
    });

    group("Generic error handling", () {
      test(
        "should return UnknownError with default message for other exceptions",
        () {
          final error = Exception("Some unknown error");

          final result = handleFirebaseError(error);

          expect(result, isA<UnknownError>());
          expect(result.message, "Ocorreu um erro");
        },
      );

      test(
        "should return UnknownError with custom message for other exceptions",
        () {
          final error = Exception("Some unknown error");

          final result = handleFirebaseError(error, message: "Custom error");

          expect(result, isA<UnknownError>());
          expect(result.message, "Custom error");
        },
      );
    });
  });
}
