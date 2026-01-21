import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../domain/entites/profile_entity.dart";

abstract class ProfileDataSource {
  Future<ResultWrapper<ProfileEntity>> getProfile(String userId);
}
