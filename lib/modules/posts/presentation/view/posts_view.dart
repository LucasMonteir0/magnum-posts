import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

import "../../../commons/presentation/components/app_error_view.dart";
import "../../../commons/presentation/components/custom_app_bar.dart";
import "../../../commons/presentation/components/loading_indicator.dart";
import "../../../commons/utils/resources/theme/app_theme.dart";
import "../../../commons/utils/states/base_state.dart";
import "../blocs/get_posts/get_posts_bloc.dart";
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
      body: BlocBuilder<GetPostsBloc, BaseState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is LoadingState && _bloc.displayedPosts.isEmpty) {
            return const LoadingIndicator();
          }

          if (state is ErrorState && _bloc.displayedPosts.isEmpty) {
            return AppErrorView(
              message: state.error.message,
              onRetry: () => _bloc.loadPosts(),
            );
          }

          final posts = _bloc.displayedPosts;

          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            itemCount: posts.length + (_bloc.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == posts.length) {
                return const LoadingIndicator();
              }
              return PostCard(post: posts[index], index: index);
            },
          );
        },
      ),
    );
  }
}
