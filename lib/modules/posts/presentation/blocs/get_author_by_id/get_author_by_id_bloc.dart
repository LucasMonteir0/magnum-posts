import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../commons/utils/states/base_state.dart";
import "../../../core/domain/entities/author_entity.dart";
import "../../../core/domain/use_cases/get_author_by_id/get_author_by_id_use_case.dart";

class GetAuthorByIdBloc extends Cubit<BaseState> {
  final GetAuthorByIdUseCase _useCase;

  GetAuthorByIdBloc(this._useCase) : super(const InitialState());

  Future<void> call(int id) async {
    emit(const LoadingState());
    final result = await _useCase.call(id);
    if (result.isSuccess) {
      emit(SuccessState<AuthorEntity>(result.data!));
      return;
    }
    emit(ErrorState(result.error));
  }
}
