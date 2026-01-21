part of "../post_details_view.dart";

class _AuthorHeader extends StatelessWidget {
  final BaseState authorState;
  final ColorScheme colorScheme;
  final ThemeData theme;

  const _AuthorHeader({
    required this.authorState,
    required this.colorScheme,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    if (authorState is LoadingState) {
      return Row(
        children: [
          CircleAvatar(
            radius: AppSizes.avatarSm / 2,
            backgroundColor: colorScheme.surfaceContainerHighest,
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            width: 100,
            height: 16,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
            ),
          ),
        ],
      );
    }

    if (authorState is SuccessState<AuthorEntity>) {
      final author = (authorState as SuccessState<AuthorEntity>).data;
      return Row(
        children: [
          CircleAvatar(
            radius: AppSizes.avatarSm / 2,
            backgroundColor: colorScheme.primaryContainer,
            child: Text(
              author.name.isNotEmpty ? author.name[0].toUpperCase() : "?",
              style: theme.textTheme.titleSmall?.copyWith(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  author.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Autor",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    if (authorState is ErrorState) {
      return Row(
        children: [
          CircleAvatar(
            radius: AppSizes.avatarSm / 2,
            backgroundColor: colorScheme.errorContainer,
            child: Icon(
              Icons.person_off_outlined,
              size: AppSizes.iconSm,
              color: colorScheme.onErrorContainer,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            "Autor não encontrado",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.error,
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
