import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

import "../../../commons/presentation/components/app_error_view.dart";
import "../../../commons/presentation/components/custom_app_bar.dart";
import "../../../commons/presentation/components/loading_indicator.dart";
import "../../../commons/utils/config/routes.dart";
import "../../../commons/utils/resources/theme/app_theme.dart";
import "../../core/domain/entities/post_entity.dart";
import "../blocs/get_posts/get_posts_bloc.dart";
import "../blocs/get_posts/get_posts_state.dart";
import "../components/post_card.dart";

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  late final GetPostsBloc _bloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<GetPostsBloc>();
    _bloc.loadPosts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _bloc.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Posts"),
      body: BlocBuilder<GetPostsBloc, GetPostsState>(
        bloc: _bloc,
        builder: (context, state) {
          return switch (state) {
            GetPostsInitial() => const SizedBox.shrink(),
            GetPostsLoading(posts: final posts) when posts.isEmpty =>
              const LoadingIndicator(),
            GetPostsError(posts: final posts, message: final message)
                when posts.isEmpty =>
              AppErrorView(message: message, onRetry: () => _bloc.loadPosts()),
            GetPostsSuccess(posts: final posts, hasMore: final hasMore) =>
              _PostsList(
                posts: posts,
                hasMore: hasMore,
                scrollController: _scrollController,
              ),
            GetPostsLoading(posts: final posts, hasMore: final hasMore)
                when posts.isNotEmpty =>
              _PostsList(
                posts: posts,
                hasMore: hasMore,
                scrollController: _scrollController,
              ),
            GetPostsError(posts: final posts, hasMore: final hasMore)
                when posts.isNotEmpty =>
              _PostsList(
                posts: posts,
                hasMore: hasMore,
                scrollController: _scrollController,
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}

class _PostsList extends StatelessWidget {
  final List<PostEntity> posts;
  final bool hasMore;
  final ScrollController scrollController;

  const _PostsList({
    required this.posts,
    required this.hasMore,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      itemCount: posts.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == posts.length) {
          return const LoadingIndicator();
        }
        final post = posts[index];
        return PostCard(
          post: post,
          index: index,
          onTap: () => Modular.to.pushNamed(
            "${Routes.posts}${Routes.postDetails}/${post.id}",
          ),
        );
      },
    );
  }
}
