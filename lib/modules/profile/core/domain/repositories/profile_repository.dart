import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../entites/profile_entity.dart";

abstract class ProfileRepository {
  Future<ResultWrapper<ProfileEntity>> getProfile(String userId);
}
