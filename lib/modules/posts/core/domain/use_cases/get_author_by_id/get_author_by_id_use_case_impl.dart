import '../../../../../commons/core/domain/entities/result_wrapper.dart';
import '../../entities/author_entity.dart';
import '../../repositories/posts_repository.dart';
import 'get_author_by_id_use_case.dart';

class GetAuthorByIdUseCaseImpl implements GetAuthorByIdUseCase {
  final PostsRepository _repository;

  GetAuthorByIdUseCaseImpl(this._repository);

  @override
  Future<ResultWrapper<AuthorEntity>> call(int id) async {
    return _repository.getAuthorById(id);
  }
}
