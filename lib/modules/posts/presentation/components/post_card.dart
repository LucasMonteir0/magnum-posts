import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";

import "../../../commons/presentation/components/expandable_text.dart";
import "../../../commons/utils/resources/theme/app_theme.dart";
import "../../core/domain/entities/post_entity.dart";

class PostCard extends StatelessWidget {
  final PostEntity post;
  final int index;

  const PostCard({required this.post, super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final delay = Duration(milliseconds: (index % 10) * 50);

    return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                ExpandableText(text: post.body),
              ],
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
