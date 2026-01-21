import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../entites/profile_entity.dart";

abstract class GetProfileUseCase {
  GetProfileUseCase(Object object);

  Future<ResultWrapper<ProfileEntity>> call(String userId);
}
