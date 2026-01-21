import "package:flutter_bloc/flutter_bloc.dart";
import "../../../commons/utils/states/base_state.dart";
import "../../core/domain/use_cases/sign_in/sign_in_use_case.dart";

class SignInBloc extends Cubit<BaseState> {
  final SignInUseCase useCase;

  SignInBloc(this.useCase) : super(const InitialState());

  void call(String email, String password) async {
    emit(const LoadingState());

    final result = await useCase(email, password);

    if (result.isSuccess) {
      emit(const SuccessState(true));
    } else {
      emit(ErrorState(result.error));
    }
  }
}
