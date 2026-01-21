import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

import "../../../commons/presentation/components/app_error_view.dart";
import "../../../commons/presentation/components/custom_app_bar.dart";
import "../../../commons/presentation/components/loading_indicator.dart";
import "../../../commons/utils/resources/theme/app_theme.dart";
import "../../../commons/utils/states/base_state.dart";
import "../../core/domain/entities/author_entity.dart";
import "../../core/domain/entities/post_entity.dart";
import "../blocs/get_author_by_id/get_author_by_id_bloc.dart";
import "../blocs/get_post_by_id/get_post_by_id_bloc.dart";

part "sections/author_header.dart";

class PostDetailsView extends StatefulWidget {
  final String postId;

  const PostDetailsView({required this.postId, super.key});

  @override
  State<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends State<PostDetailsView> {
  late final GetPostByIdBloc _postBloc;
  late final GetAuthorByIdBloc _authorBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = Modular.get<GetPostByIdBloc>();
    _authorBloc = Modular.get<GetAuthorByIdBloc>();
    _loadPost();
  }

  void _loadPost() {
    final id = int.tryParse(widget.postId);
    if (id != null) {
      _postBloc.call(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: const CustomAppBar(title: "Detalhes", showBackButton: true),
      body: BlocConsumer<GetPostByIdBloc, BaseState>(
        bloc: _postBloc,
        listener: (context, state) {
          if (state is SuccessState<PostEntity>) {
            _authorBloc.call(state.data.userId);
          }
        },
        builder: (context, state) {
          return switch (state) {
            LoadingState() => const LoadingIndicator(),
            ErrorState(error: final error) => AppErrorView(
              message: error.message,
              onRetry: _loadPost,
            ),
            SuccessState<PostEntity>(data: final post) => SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<GetAuthorByIdBloc, BaseState>(
                        bloc: _authorBloc,
                        builder: (context, authorState) {
                          return _AuthorHeader(
                            authorState: authorState,
                            colorScheme: colorScheme,
                            theme: theme,
                          );
                        },
                      )
                      .animate()
                      .fadeIn(duration: 300.ms, curve: Curves.easeOut)
                      .slideX(begin: -0.1, end: 0, duration: 300.ms),
                  const SizedBox(height: AppSpacing.lg),

                  Text(
                        post.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 100.ms)
                      .slideY(begin: 0.1, end: 0, duration: 400.ms),
                  const SizedBox(height: AppSpacing.md),

                  Divider(color: colorScheme.outlineVariant)
                      .animate()
                      .fadeIn(duration: 300.ms, delay: 200.ms)
                      .scaleX(
                        begin: 0,
                        end: 1,
                        duration: 400.ms,
                        curve: Curves.easeOut,
                      ),
                  const SizedBox(height: AppSpacing.md),

                  Text(
                        post.body,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 300.ms)
                      .slideY(begin: 0.05, end: 0, duration: 400.ms),
                ],
              ),
            ),

            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
