import '../../entities/api/api_response.dart';

abstract class HttpService {
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  });

  Future<ApiResponse<T>> post<T>(String path, {dynamic data});

  Future<ApiResponse<T>> put<T>(String path, {dynamic data});

  Future<ApiResponse<T>> delete<T>(String path, {dynamic data});

  Future<ApiResponse<T>> patch<T>(String path, {dynamic data});
}
