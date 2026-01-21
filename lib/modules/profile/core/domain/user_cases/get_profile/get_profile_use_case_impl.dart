import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../entites/profile_entity.dart";
import "../../repositories/profile_repository.dart";
import "get_profile_use_case.dart";

class GetProfileUseCaseImpl implements GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCaseImpl(this._repository);

  @override
  Future<ResultWrapper<ProfileEntity>> call(String userId) {
    return _repository.getProfile(userId);
  }
}
