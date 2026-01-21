import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../entities/author_entity.dart";
import "../entities/post_entity.dart";

abstract class PostsRepository {
  Future<ResultWrapper<List<PostEntity>>> getPosts();
  Future<ResultWrapper<PostEntity>> getPostById(int id);
  Future<ResultWrapper<AuthorEntity>> getAuthorById(int id);
}
