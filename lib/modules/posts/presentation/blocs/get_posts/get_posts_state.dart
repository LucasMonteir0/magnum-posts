import "package:equatable/equatable.dart";

import "../../../core/domain/entities/post_entity.dart";

sealed class GetPostsState extends Equatable {
  const GetPostsState();

  @override
  List<Object?> get props => [];
}

final class GetPostsInitial extends GetPostsState {
  const GetPostsInitial();
}

final class GetPostsLoading extends GetPostsState {
  final List<PostEntity> posts;
  final bool hasMore;

  const GetPostsLoading({this.posts = const [], this.hasMore = true});

  @override
  List<Object?> get props => [posts, hasMore];
}

final class GetPostsSuccess extends GetPostsState {
  final List<PostEntity> posts;
  final bool hasMore;

  const GetPostsSuccess({required this.posts, required this.hasMore});

  @override
  List<Object?> get props => [posts, hasMore];
}

final class GetPostsError extends GetPostsState {
  final String message;
  final List<PostEntity> posts;
  final bool hasMore;

  const GetPostsError({
    required this.message,
    this.posts = const [],
    this.hasMore = false,
  });

  @override
  List<Object?> get props => [message, posts, hasMore];
}
