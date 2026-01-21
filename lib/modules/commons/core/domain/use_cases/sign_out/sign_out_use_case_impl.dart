import "../../entities/result_wrapper.dart";
import "../../repositories/sign_out_repository.dart";
import "sign_out_use_case.dart";

class SignOutUseCaseImpl implements SignOutUseCase {
  final SignOutRepository _repository;

  SignOutUseCaseImpl(this._repository);

  @override
  Future<ResultWrapper<bool>> call() {
    return _repository.signOut();
  }
}
