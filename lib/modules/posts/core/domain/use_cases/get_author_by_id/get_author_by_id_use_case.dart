import '../../../../../commons/core/domain/entities/result_wrapper.dart';
import '../../entities/author_entity.dart';

abstract class GetAuthorByIdUseCase {
  Future<ResultWrapper<AuthorEntity>> call(int id);
}
