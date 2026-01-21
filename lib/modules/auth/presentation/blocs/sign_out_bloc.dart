import "package:flutter_bloc/flutter_bloc.dart";
import "../../../commons/utils/states/base_state.dart";
import "../../core/domain/use_cases/sign_out/sign_out_use_case.dart";

class SignOutBloc extends Cubit<BaseState> {
  final SignOutUseCase useCase;

  SignOutBloc(this.useCase) : super(const InitialState());

  void call() async {
    emit(const LoadingState());

    final result = await useCase.call();

    if (result.isSuccess) {
      emit(const SuccessState<bool>(true));
    } else {
      emit(ErrorState(result.error));
    }
  }
}
