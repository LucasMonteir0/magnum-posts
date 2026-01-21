import "../../entities/result_wrapper.dart";

abstract class SignOutUseCase {
  Future<ResultWrapper<bool>> call();
}
