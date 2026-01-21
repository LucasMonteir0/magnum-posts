import '../../../../../commons/core/domain/entities/result_wrapper.dart';
import '../../entities/post_entity.dart';

abstract class GetPostByIdUseCase {
  Future<ResultWrapper<PostEntity>> call(int id);
}
