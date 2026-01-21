import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../domain/entites/profile_entity.dart";
import "../../domain/repositories/profile_repository.dart";
import "../datasources/profile_datasource.dart";

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource _dataSource;

  ProfileRepositoryImpl(this._dataSource);

  @override
  Future<ResultWrapper<ProfileEntity>> getProfile(String userId) {
    return _dataSource.getProfile(userId);
  }
}
