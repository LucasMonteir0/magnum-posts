import "package:flutter_bloc/flutter_bloc.dart";
import "../../../../commons/utils/states/base_state.dart";

import "../../../core/domain/entities/post_entity.dart";
import "../../../core/domain/use_cases/get_posts/get_posts_use_case.dart";

// A API não possui paginação, então simula-se um atraso de 1.5 segundos para simular a paginação

class GetPostsBloc extends Cubit<BaseState> {
  final GetPostsUseCase _useCase;
  final List<PostEntity> _allPosts = [];
  final List<PostEntity> _displayedPosts = [];
  static const int _pageSize = 10;
  bool _hasMore = true;
  bool _isLoading = false;
  GetPostsBloc(this._useCase) : super(const InitialState());

  List<PostEntity> get displayedPosts => _displayedPosts;
  bool get hasMore => _hasMore;

  // Carrega todos os posts da API
  Future<void> loadPosts() async {
    if (_allPosts.isEmpty) {
      emit(const LoadingState());
      final result = await _useCase.call();

      if (result.isSuccess && result.data != null) {
        _allPosts.addAll(result.data!);
        _loadNextPage();
      } else {
        emit(ErrorState(result.error));
      }
    }
  }

  // Carrega mais posts quando o scroll atinge o final
  Future<void> loadMore() async {
    if (_hasMore && !_isLoading) {
      await _loadNextPage();
    }
  }

  // Pagina localmente os posts carregados
  Future<void> _loadNextPage() async {
    if (_isLoading) return;
    _isLoading = true;

    emit(const LoadingState());

    final currentLength = _displayedPosts.length;
    final endIndex = (currentLength + _pageSize).clamp(0, _allPosts.length);

    if (currentLength < _allPosts.length) {
      _displayedPosts.addAll(_allPosts.sublist(currentLength, endIndex));
      _hasMore = _displayedPosts.length < _allPosts.length;

      // Simula um atraso de 1.5 segundos
      await Future.delayed(const Duration(milliseconds: 1500));
      emit(
        SuccessState<List<PostEntity>>(List<PostEntity>.from(_displayedPosts)),
      );
    } else {
      _hasMore = false;
      emit(
        SuccessState<List<PostEntity>>(List<PostEntity>.from(_displayedPosts)),
      );
    }

    _isLoading = false;
  }
}
