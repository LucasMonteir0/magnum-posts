import "../../domain/entities/result_wrapper.dart";
import "../../domain/repositories/sign_out_repository.dart";
import "../datasources/sign_out_datasource.dart";

class SignOutRepositoryImpl implements SignOutRepository {
  final SignOutDataSource _dataSource;

  SignOutRepositoryImpl(this._dataSource);

  @override
  Future<ResultWrapper<bool>> signOut() {
    return _dataSource.signOut();
  }
}
