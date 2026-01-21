import "package:dio/dio.dart";

class ApiError {
  final String message;
  final int? statusCode;
  final DioExceptionType errorType;
  final dynamic errorData;

  ApiError({
    required this.message,
    required this.errorType,
    this.statusCode,
    this.errorData,
  });

  factory ApiError.fromDioException(DioException dioException) {
    return ApiError(
      message: dioException.message ?? "",
      statusCode: dioException.response?.statusCode,
      errorType: dioException.type,
      errorData: dioException.response?.data,
    );
  }
}
