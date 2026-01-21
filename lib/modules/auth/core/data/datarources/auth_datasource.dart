import "../../../../commons/core/domain/entities/result_wrapper.dart";

abstract class AuthDataSource {
  Future<ResultWrapper<bool>> signIn(String email, String password);
}
