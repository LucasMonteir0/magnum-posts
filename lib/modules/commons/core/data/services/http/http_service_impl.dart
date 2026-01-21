import "package:dio/dio.dart";
import "package:flutter/foundation.dart";

import "../../../domain/entities/api/api_error.dart";
import "../../../domain/entities/api/api_response.dart";
import "../../../domain/services/http/http_service.dart";

class HttpServiceImpl extends HttpService {
  final Dio _dio;

  HttpServiceImpl(this._dio) {
    _setupLogging();
  }

  void _setupLogging() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            print("REQUEST[${options.method}] => PATH: ${options.path}");
            print("REQUEST[${options.method}] => BODY: ${options.data}");
            print(
              "REQUEST[${options.method}] => QUERY: ${options.queryParameters}",
            );
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print(
              "RESPONSE[${response.statusCode}] => DATA: ${response.data is List<int> ? 'BYTES => List<int>' : response.data}",
            );
          }
          handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            print(
              "ERROR[${e.response?.statusCode}] => MESSAGE: ${e.response?.data}",
            );
          }
          handler.next(e);
        },
      ),
    );
  }

  Future<ApiResponse<T>> _request<T>(Future<Response<T>> futureRequest) async {
    try {
      Response<T> response = await futureRequest;
      return ApiResponse.fromDioResponse(response);
    } catch (e) {
      if (e is DioException) {
        throw ApiError.fromDioException(e);
      } else {
        throw ApiError(
          message: e.toString(),
          errorType: DioExceptionType.unknown,
        );
      }
    }
  }

  @override
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _request<T>(
      _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: {"Accept": "application/json"}),
      ),
    );
  }

  @override
  Future<ApiResponse<T>> post<T>(String path, {dynamic data}) async {
    return await _request<T>(_dio.post(path, data: data));
  }

  @override
  Future<ApiResponse<T>> put<T>(String path, {dynamic data}) async {
    return await _request<T>(_dio.put(path, data: data));
  }

  @override
  Future<ApiResponse<T>> delete<T>(String path, {dynamic data}) async {
    return await _request<T>(_dio.delete(path, data: data));
  }

  @override
  Future<ApiResponse<T>> patch<T>(String path, {dynamic data}) async {
    return await _request<T>(_dio.patch(path, data: data));
  }
}
