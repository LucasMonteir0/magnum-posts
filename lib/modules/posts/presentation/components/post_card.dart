import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";

import "../../../commons/utils/resources/theme/app_theme.dart";
import "../../core/domain/entities/post_entity.dart";

class PostCard extends StatefulWidget {
  final PostEntity post;
  final int index;

  const PostCard({required this.post, super.key, this.index = 0});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late final ValueNotifier<bool> _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    _isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final body = widget.post.body;
    final shouldTruncate = body.length > 100;
    final delay = Duration(milliseconds: (widget.index % 10) * 50);

    return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: ValueListenableBuilder(
              valueListenable: _isExpanded,
              builder: (context, isExpanded, _) {
                final displayBody = isExpanded || !shouldTruncate
                    ? body
                    : "${body.substring(0, 100)}...";
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      displayBody,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (shouldTruncate)
                      GestureDetector(
                        onTap: () => _isExpanded.value = !_isExpanded.value,
                        child: Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.xs),
                          child: Text(
                            isExpanded ? "Ver menos" : "Ver mais",
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        )
        .animate(delay: delay)
        .fadeIn(duration: 400.ms, curve: Curves.easeOutQuad)
        .slideY(
          begin: 0.15,
          end: 0,
          duration: 400.ms,
          curve: Curves.easeOutQuad,
        )
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          duration: 300.ms,
        );
  }
}
