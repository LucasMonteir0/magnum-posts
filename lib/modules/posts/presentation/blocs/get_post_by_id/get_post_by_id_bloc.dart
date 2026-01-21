import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../commons/utils/states/base_state.dart";
import "../../../core/domain/entities/post_entity.dart";
import "../../../core/domain/use_cases/get_post_by_id/get_post_by_id_use_case.dart";

class GetPostByIdBloc extends Cubit<BaseState> {
  final GetPostByIdUseCase _useCase;

  GetPostByIdBloc(this._useCase) : super(const InitialState());

  Future<void> call(int id) async {
    emit(const LoadingState());
    final result = await _useCase.call(id);
    if (result.isSuccess) {
      emit(SuccessState<PostEntity>(result.data!));
    } else {
      emit(ErrorState(result.error));
    }
  }
}
