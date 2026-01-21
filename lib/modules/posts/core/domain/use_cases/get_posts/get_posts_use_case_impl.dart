import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../entities/post_entity.dart";
import "../../repositories/posts_repository.dart";
import "get_posts_use_case.dart";

class GetPostsUseCaseImpl implements GetPostsUseCase {
  final PostsRepository _repository;

  GetPostsUseCaseImpl(this._repository);

  @override
  Future<ResultWrapper<List<PostEntity>>> call() async {
    return _repository.getPosts();
  }
}
