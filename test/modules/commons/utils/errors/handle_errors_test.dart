import 'package:flutter_test/flutter_test.dart';
import 'package:magnum_posts/modules/commons/utils/errors/errors.dart';
import 'package:magnum_posts/modules/commons/utils/errors/handle_errors.dart';

void main() {
  group('handleError', () {
    test('should return NotFoundError for status 404', () {
      final error = handleError(404, message: 'Not found');

      expect(error, isA<NotFoundError>());
      expect(error.code, 404);
      expect(error.message, 'Not found');
    });

    test('should return ForBidenError for status 403', () {
      final error = handleError(403);

      expect(error, isA<ForBidenError>());
      expect(error.code, 403);
    });

    test('should return BadRequestError for status 400', () {
      final error = handleError(400);

      expect(error, isA<BadRequestError>());
      expect(error.code, 400);
    });

    test('should return UnauthorizedError for status 401', () {
      final error = handleError(401);

      expect(error, isA<UnauthorizedError>());
      expect(error.code, 401);
    });

    test('should return InternalServerError for status 500', () {
      final error = handleError(500);

      expect(error, isA<InternalServerError>());
      expect(error.code, 500);
    });

    test('should return ServiceUnavailableError for status 503', () {
      final error = handleError(503);

      expect(error, isA<ServiceUnavailableError>());
      expect(error.code, 503);
    });

    test('should return ConflictError for status 409', () {
      final error = handleError(409);

      expect(error, isA<ConflictError>());
      expect(error.code, 409);
    });

    test('should return UnProcessableEntityError for status 422', () {
      final error = handleError(422);

      expect(error, isA<UnProcessableEntityError>());
      expect(error.code, 422);
    });

    test('should return TooManyRequestsError for status 429', () {
      final error = handleError(429);

      expect(error, isA<TooManyRequestsError>());
      expect(error.code, 429);
    });

    test('should return MethodNotAllowedError for status 405', () {
      final error = handleError(405);

      expect(error, isA<MethodNotAllowedError>());
      expect(error.code, 405);
    });

    test('should return NotAcceptableError for status 406', () {
      final error = handleError(406);

      expect(error, isA<NotAcceptableError>());
      expect(error.code, 406);
    });

    test('should return ProxyAuthenticationRequiredError for status 407', () {
      final error = handleError(407);

      expect(error, isA<ProxyAuthenticationRequiredError>());
      expect(error.code, 407);
    });

    test('should return RequestTimeoutError for status 408', () {
      final error = handleError(408);

      expect(error, isA<RequestTimeoutError>());
      expect(error.code, 408);
    });

    test('should return GoneError for status 410', () {
      final error = handleError(410);

      expect(error, isA<GoneError>());
      expect(error.code, 410);
    });

    test('should return LengthRequiredError for status 411', () {
      final error = handleError(411);

      expect(error, isA<LengthRequiredError>());
      expect(error.code, 411);
    });

    test('should return PreconditionFailedError for status 412', () {
      final error = handleError(412);

      expect(error, isA<PreconditionFailedError>());
      expect(error.code, 412);
    });

    test('should return PayloadTooLargeError for status 413', () {
      final error = handleError(413);

      expect(error, isA<PayloadTooLargeError>());
      expect(error.code, 413);
    });

    test('should return URITooLongError for status 414', () {
      final error = handleError(414);

      expect(error, isA<URITooLongError>());
      expect(error.code, 414);
    });

    test('should return UnsupportedMediaTypeError for status 415', () {
      final error = handleError(415);

      expect(error, isA<UnsupportedMediaTypeError>());
      expect(error.code, 415);
    });

    test('should return RangeNotSatisfiableError for status 416', () {
      final error = handleError(416);

      expect(error, isA<RangeNotSatisfiableError>());
      expect(error.code, 416);
    });

    test('should return ExpectationFailedError for status 417', () {
      final error = handleError(417);

      expect(error, isA<ExpectationFailedError>());
      expect(error.code, 417);
    });

    test('should return MisdirectedRequestError for status 421', () {
      final error = handleError(421);

      expect(error, isA<MisdirectedRequestError>());
      expect(error.code, 421);
    });

    test('should return UpgradeRequiredError for status 426', () {
      final error = handleError(426);

      expect(error, isA<UpgradeRequiredError>());
      expect(error.code, 426);
    });

    test('should return PreconditionRequiredError for status 428', () {
      final error = handleError(428);

      expect(error, isA<PreconditionRequiredError>());
      expect(error.code, 428);
    });

    test('should return NetworkAuthenticationRequiredError for status 511', () {
      final error = handleError(511);

      expect(error, isA<NetworkAuthenticationRequiredError>());
      expect(error.code, 511);
    });

    test('should return UnknownError for unknown status codes', () {
      final error = handleError(999);

      expect(error, isA<UnknownError>());
      expect(error.code, -1);
    });

    test('should return UnknownError for null status code', () {
      final error = handleError(null);

      expect(error, isA<UnknownError>());
      expect(error.code, -1);
    });

    test('should use custom message when provided', () {
      final error = handleError(500, message: 'Custom error message');

      expect(error.message, 'Custom error message');
    });

    test('should use default message when not provided', () {
      final error = handleError(999);

      expect(error.message, 'Ocorreu um erro');
    });
  });
}
