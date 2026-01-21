import "package:dio/dio.dart";
import "package:firebase_core/firebase_core.dart";

import "../../../commons/core/domain/entities/api/api_error.dart";
import "../../../commons/core/domain/entities/base_error.dart";
import "../../../commons/utils/errors/errors.dart";
import "../../../commons/utils/errors/handle_errors.dart";

BaseError handleFirebaseError(
  Object error, {
  String message = "Ocorreu um erro",
}) {
  if (error is FirebaseException) {
    switch (error.code) {
      case "user-not-found":
        return BadRequestError(message: "Email ou senha incorrentos");
      case "wrong-password":
        return BadRequestError(message: "Email ou senha incorrentos");
      case "invalid-email":
        return BadRequestError(message: "Email ou senha incorrentos");
      case "invalid-credential":
        return BadRequestError(message: "Email ou senha incorrentos");
      case "user-token-expired":
        return ForBidenError(message: "É necessário fazer o login");
      case "user-disabled":
        return ForBidenError(message: "Usuário desativado");
      case "email-already-in-use":
        return ConflictError(message: "Email já cadastrado");
      case "too-many-requests":
        return TooManyRequestsError(
          message: "Espere alguns minutos e tente novamente",
        );
      case "network-request-failed":
        return BadGatewayError(message: "Você não está conectado à internet");
      case "operation-not-allowed":
        return ForBidenError(message: message);
      default:
        return UnknownError(message: message);
    }
  }

  if (error is DioException) {
    final dioError = ApiError.fromDioException(error);
    return handleError(dioError.statusCode);
  }
  return UnknownError(message: message);
}
