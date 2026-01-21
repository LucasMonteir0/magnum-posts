import "package:flutter_bloc/flutter_bloc.dart";

import "../../../commons/utils/cache/app_cache.dart";
import "../../../commons/utils/errors/errors.dart";
import "../../../commons/utils/states/base_state.dart";
import "../../core/domain/entites/profile_entity.dart";
import "../../core/domain/user_cases/get_profile/get_profile_use_case.dart";

class GetProfileBloc extends Cubit<BaseState> {
  final GetProfileUseCase _useCase;
  GetProfileBloc(this._useCase) : super(const InitialState());

  void call() async {
    emit(const LoadingState());

    final userId = AppCache.instance.getUserId();

    if (userId == null) {
      emit(ErrorState(BadRequestError(message: "Usuário não está logado.")));
      return;
    }

    final result = await _useCase.call(userId);

    if (result.isSuccess) {
      emit(SuccessState<ProfileEntity>(result.data!));
      return;
    }
    emit(ErrorState(result.error));
  }
}
