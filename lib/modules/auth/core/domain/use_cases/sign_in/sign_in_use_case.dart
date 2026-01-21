import "../../../../../commons/core/domain/entities/result_wrapper.dart";

abstract class SignInUseCase {
  Future<ResultWrapper<bool>> call(String email, String password);
}
