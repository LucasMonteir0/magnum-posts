import '../../../../../commons/core/domain/entities/result_wrapper.dart';
import '../../entities/post_entity.dart';

abstract class GetPostsUseCase {
  Future<ResultWrapper<List<PostEntity>>> call();
}
