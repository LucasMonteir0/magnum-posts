import "package:dio/dio.dart";

class ApiResponse<T> {
  final T? data;
  final int? statusCode;
  final String? statusMessage;
  final Map<String, dynamic>? headers;

  ApiResponse({this.data, this.statusCode, this.statusMessage, this.headers});

  factory ApiResponse.fromDioResponse(Response<T> response) {
    return ApiResponse(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      headers: response.headers.map,
    );
  }
}
