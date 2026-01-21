import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../repositories/auth_repository.dart";
import "sign_in_use_case.dart";

class SignInUseCaseImpl implements SignInUseCase {
  final AuthRepository repository;

  SignInUseCaseImpl(this.repository);

  @override
  Future<ResultWrapper<String>> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
