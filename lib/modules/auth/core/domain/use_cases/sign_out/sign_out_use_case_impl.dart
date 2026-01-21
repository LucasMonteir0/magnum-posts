import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../repositories/auth_repository.dart";
import "sign_out_use_case.dart";

class SignOutUseCaseImpl implements SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCaseImpl(this._repository);

  Future<ResultWrapper<bool>> call() {
    return _repository.signOut();
  }
}
