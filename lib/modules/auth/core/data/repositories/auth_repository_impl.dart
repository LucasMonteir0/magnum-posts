import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../domain/repositories/auth_repository.dart";
import "../datarources/auth_datasource.dart";

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<ResultWrapper<bool>> signIn(String email, String password) {
    return dataSource.signIn(email, password);
  }
}
