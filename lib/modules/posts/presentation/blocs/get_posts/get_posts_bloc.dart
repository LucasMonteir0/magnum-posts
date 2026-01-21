import "package:flutter_bloc/flutter_bloc.dart";

import "../../../core/domain/entities/post_entity.dart";
import "../../../core/domain/use_cases/get_posts/get_posts_use_case.dart";
import "get_posts_state.dart";

// A API não possui paginação, então simula-se um atraso de 1.5 segundos

class GetPostsBloc extends Cubit<GetPostsState> {
  final GetPostsUseCase _useCase;
  final List<PostEntity> _allPosts = [];
  final List<PostEntity> _displayedPosts = [];
  static const int _pageSize = 10;
  bool _hasMore = true;
  bool _isLoading = false;

  GetPostsBloc(this._useCase) : super(const GetPostsInitial());

  void loadPosts() async {
    if (_allPosts.isEmpty) {
      emit(const GetPostsLoading());
      final result = await _useCase.call();

      if (result.isSuccess && result.data != null) {
        _allPosts.addAll(result.data!);
        _loadNextPage();
      } else {
        emit(
          GetPostsError(message: result.error?.message ?? "Erro desconhecido"),
        );
      }
    }
  }

  void loadMore() {
    if (_hasMore && !_isLoading) {
      _loadNextPage();
    }
  }

  void _loadNextPage() async {
    if (_isLoading) return;
    _isLoading = true;

    emit(
      GetPostsLoading(
        posts: List.unmodifiable(_displayedPosts),
        hasMore: _hasMore,
      ),
    );

    final currentLength = _displayedPosts.length;
    final endIndex = (currentLength + _pageSize).clamp(0, _allPosts.length);

    if (currentLength < _allPosts.length) {
      _displayedPosts.addAll(_allPosts.sublist(currentLength, endIndex));
      _hasMore = _displayedPosts.length < _allPosts.length;

      await Future.delayed(const Duration(milliseconds: 1500));

      emit(
        GetPostsSuccess(
          posts: List.unmodifiable(_displayedPosts),
          hasMore: _hasMore,
        ),
      );
    } else {
      _hasMore = false;
      emit(
        GetPostsSuccess(
          posts: List.unmodifiable(_displayedPosts),
          hasMore: false,
        ),
      );
    }

    _isLoading = false;
  }
}
