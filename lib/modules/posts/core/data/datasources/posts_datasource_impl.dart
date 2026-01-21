import "../../../../commons/config/urls.dart";
import "../../../../commons/core/domain/entities/api/api_error.dart";
import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../../../commons/core/domain/services/http/http_service.dart";
import "../../../../commons/utils/errors/errors.dart";
import "../../../../commons/utils/errors/handle_errors.dart";
import "../../domain/entities/author_entity.dart";
import "../../domain/entities/post_entity.dart";
import "../models/author_model.dart";
import "../models/post_model.dart";
import "posts_datasource.dart";

class PostsDatasourceImpl implements PostsDatasource {
  final HttpService _service;

  PostsDatasourceImpl(this._service);

  @override
  Future<ResultWrapper<List<PostEntity>>> getPosts() async {
    try {
      final response = await _service.get("${Urls.baseUrl}/posts/");
      final result = (response.data as List)
          .map((e) => PostModel.fromJson(e))
          .toList();

      return ResultWrapper.success(result);
    } on ApiError catch (e) {
      final error = handleError(e.statusCode, message: e.message);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(UnknownError(message: e.toString()));
    }
  }

  @override
  Future<ResultWrapper<PostEntity>> getPostById(int id) async {
    try {
      final response = await _service.get("${Urls.baseUrl}/posts/$id");
      final result = PostModel.fromJson(response.data);
      return ResultWrapper.success(result);
    } on ApiError catch (e) {
      final error = handleError(e.statusCode, message: e.message);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(UnknownError(message: e.toString()));
    }
  }

  @override
  Future<ResultWrapper<AuthorEntity>> getAuthorById(int id) async {
    try {
      final response = await _service.get("${Urls.baseUrl}/users/$id");
      final result = AuthorModel.fromJson(response.data);
      return ResultWrapper.success(result);
    } on ApiError catch (e) {
      final error = handleError(e.statusCode, message: e.message);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(UnknownError(message: e.toString()));
    }
  }
}
