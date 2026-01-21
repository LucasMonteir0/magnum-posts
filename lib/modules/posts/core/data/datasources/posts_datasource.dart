import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../domain/entities/author_entity.dart";
import "../../domain/entities/post_entity.dart";

abstract class PostsDatasource {
  Future<ResultWrapper<List<PostEntity>>> getPosts();
  Future<ResultWrapper<PostEntity>> getPostById(int id);
  Future<ResultWrapper<AuthorEntity>> getAuthorById(int id);
}
