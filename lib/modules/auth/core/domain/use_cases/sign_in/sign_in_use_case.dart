import "../../../../../commons/core/domain/entities/result_wrapper.dart";

abstract class SignInUseCase {
  Future<ResultWrapper<String>> call(String email, String password);
}
