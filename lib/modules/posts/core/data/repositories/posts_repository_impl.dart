import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../domain/entities/author_entity.dart";
import "../../domain/entities/post_entity.dart";
import "../../domain/repositories/posts_repository.dart";
import "../datasources/posts_datasource.dart";

class PostsRepositoryImpl implements PostsRepository {
  final PostsDatasource _datasource;

  PostsRepositoryImpl(this._datasource);

  @override
  Future<ResultWrapper<List<PostEntity>>> getPosts() async {
    return _datasource.getPosts();
  }

  @override
  Future<ResultWrapper<PostEntity>> getPostById(int id) async {
    return _datasource.getPostById(id);
  }

  @override
  Future<ResultWrapper<AuthorEntity>> getAuthorById(int id) async {
    return _datasource.getAuthorById(id);
  }
}
