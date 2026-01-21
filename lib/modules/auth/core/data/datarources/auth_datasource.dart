import "../../../../commons/core/domain/entities/result_wrapper.dart";

abstract class AuthDataSource {
  Future<ResultWrapper<String>> signIn(String email, String password);
}
