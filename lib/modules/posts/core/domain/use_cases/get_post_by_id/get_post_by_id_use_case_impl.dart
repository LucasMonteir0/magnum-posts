import '../../../../../commons/core/domain/entities/result_wrapper.dart';
import '../../entities/post_entity.dart';
import '../../repositories/posts_repository.dart';
import 'get_post_by_id_use_case.dart';

class GetPostByIdUseCaseImpl implements GetPostByIdUseCase {
  final PostsRepository _repository;

  GetPostByIdUseCaseImpl(this._repository);

  @override
  Future<ResultWrapper<PostEntity>> call(int id) async {
    return _repository.getPostById(id);
  }
}
