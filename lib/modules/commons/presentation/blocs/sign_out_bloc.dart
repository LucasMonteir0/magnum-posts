import "package:flutter_bloc/flutter_bloc.dart";

import "../../core/domain/use_cases/sign_out/sign_out_use_case.dart";
import "../../utils/states/base_state.dart";

class SignOutBloc extends Cubit<BaseState> {
  final SignOutUseCase _useCase;

  SignOutBloc(this._useCase) : super(const InitialState());

  void call() async {
    emit(const LoadingState());

    final result = await _useCase.call();

    if (result.isSuccess) {
      emit(const SuccessState<bool>(true));
    } else {
      emit(ErrorState(result.error));
    }
  }
}
