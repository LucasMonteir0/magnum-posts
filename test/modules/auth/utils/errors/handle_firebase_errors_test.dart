import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magnum_posts/modules/auth/utils/errors/handle_firebase_errors.dart';
import 'package:magnum_posts/modules/commons/utils/errors/errors.dart';

void main() {
  group('handleFirebaseError', () {
    group('FirebaseException handling', () {
      test('should return BadRequestError for user-not-found', () {
        // Arrange
        final error = FirebaseException(
          plugin: 'firebase_auth',
          code: 'user-not-found',
          message: 'User not found',
        );

        // Act
        final result = handleFirebaseError(error);

        // Assert
        expect(result, isA<BadRequestError>());
        expect(result.message, 'Email ou senha incorrentos');
      });

      test('should return BadRequestError for wrong-password', () {
        // Arrange
        final error = FirebaseException(
          plugin: 'firebase_auth',
          code: 'wrong-password',
          message: 'Wrong password',
        );

        // Act
        final result = handleFirebaseError(error);

        // Assert
        expect(result, isA<BadRequestError>());
        expect(result.message, 'Email ou senha incorrentos');
      });

      test('should return BadRequestError for invalid-email', () {
        // Arrange
        final error = FirebaseException(
          plugin: 'firebase_auth',
          code: 'invalid-email',
          message: 'Invalid email',
        );

        // Act
        final result = handleFirebaseError(error);

        // Assert
        expect(result, isA<BadRequestError>());
        expect(result.message, 'Email ou senha incorrentos');
      });

      test('should return BadRequestError for invalid-credential', () {
        // Arrange
        final error = FirebaseException(
          plugin: 'firebase_auth',
          code: 'invalid-credential',
          message: 'Invalid credential',
        );

        // Act
        final result = handleFirebaseError(error);

        // Assert
        expect(result, isA<BadRequestError>());
        expect(result.message, 'Email ou senha incorrentos');
      });

      test('should return ForBidenError for user-token-expired', () {
        // Arrange
        final error = FirebaseException(
          plugin: 'firebase_auth',
          code: 'user-token-expired',
          message: 'Token expired',
        );

        // Act
        final result = handleFirebaseError(error);

        // Assert
        expect(result, isA<ForBidenError>());
        expect(result.message, 'É necessário fazer o login');
      });

      test('should return ForBidenError for user-disabled', () {
        // Arrange
        final error = FirebaseException(
          plugin: 'firebase_auth',
          code: 'user-disabled',
          message: 'User disabled',
        );

        // Act
        final result = handleFirebaseError(error);

        // Assert
        expect(result, isA<ForBidenError>());
        expect(result.message, 'Usuário desativado');
      });

      test('should return ConflictError for email-already-in-use', () {
        // Arrange
        final error = FirebaseException(
          plugin: 'firebase_auth',
          code: 'email-already-in-use',
          message: 'Email already in use',
        );

        // Act
        final result = handleFirebaseError(error);

        // Assert
        expect(result, isA<ConflictError>());
        expect(result.message, 'Email já cadastrado');
      });

      test('should return TooManyRequestsError for too-many-requests', () {
        // Arrange
        final error = FirebaseException(
          plugin: 'firebase_auth',
          code: 'too-many-requests',
          message: 'Too many requests',
        );

        // Act
        final result = handleFirebaseError(error);

        // Assert
        expect(result, isA<TooManyRequestsError>());
        expect(result.message, 'Espere alguns minutos e tente novamente');
      });

      test('should return BadGatewayError for network-request-failed', () {
        // Arrange
        final error = FirebaseException(
          plugin: 'firebase_auth',
          code: 'network-request-failed',
          message: 'Network request failed',
        );

        // Act
        final result = handleFirebaseError(error);

        // Assert
        expect(result, isA<BadGatewayError>());
        expect(result.message, 'Você não está conectado à internet');
      });

      test('should return ForBidenError for operation-not-allowed', () {
        // Arrange
        final error = FirebaseException(
          plugin: 'firebase_auth',
          code: 'operation-not-allowed',
          message: 'Operation not allowed',
        );

        // Act
        final result = handleFirebaseError(error, message: 'Custom message');

        // Assert
        expect(result, isA<ForBidenError>());
        expect(result.message, 'Custom message');
      });

      test('should return UnknownError for unknown Firebase error code', () {
        // Arrange
        final error = FirebaseException(
          plugin: 'firebase_auth',
          code: 'unknown-error-code',
          message: 'Unknown error',
        );

        // Act
        final result = handleFirebaseError(error);

        // Assert
        expect(result, isA<UnknownError>());
      });
    });

    group('DioException handling', () {
      test('should return appropriate error for DioException with 404', () {
        // Arrange
        final error = DioException(
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 404,
          ),
          type: DioExceptionType.badResponse,
        );

        // Act
        final result = handleFirebaseError(error);

        // Assert
        expect(result, isA<NotFoundError>());
      });

      test('should return appropriate error for DioException with 401', () {
        // Arrange
        final error = DioException(
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 401,
          ),
          type: DioExceptionType.badResponse,
        );

        // Act
        final result = handleFirebaseError(error);

        // Assert
        expect(result, isA<UnauthorizedError>());
      });

      test('should return appropriate error for DioException with 500', () {
        // Arrange
        final error = DioException(
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 500,
          ),
          type: DioExceptionType.badResponse,
        );

        // Act
        final result = handleFirebaseError(error);

        // Assert
        expect(result, isA<InternalServerError>());
      });
    });

    group('Generic error handling', () {
      test(
        'should return UnknownError with default message for other exceptions',
        () {
          // Arrange
          final error = Exception('Some unknown error');

          // Act
          final result = handleFirebaseError(error);

          // Assert
          expect(result, isA<UnknownError>());
          expect(result.message, 'Ocorreu um erro');
        },
      );

      test(
        'should return UnknownError with custom message for other exceptions',
        () {
          // Arrange
          final error = Exception('Some unknown error');

          // Act
          final result = handleFirebaseError(error, message: 'Custom error');

          // Assert
          expect(result, isA<UnknownError>());
          expect(result.message, 'Custom error');
        },
      );
    });
  });
}
