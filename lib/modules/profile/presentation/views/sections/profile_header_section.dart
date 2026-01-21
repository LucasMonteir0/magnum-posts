part of "../profile_view.dart";

class _ProfileHeaderSection extends StatelessWidget {
  final ProfileEntity profile;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _ProfileHeaderSection({
    required this.profile,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
              child: AppNetworkImage(
                imageUrl: profile.pictureUrl,
                width: 120,
                height: 120,
                radius: 60,
              ),
            )
            .animate()
            .scale(duration: 400.ms, curve: Curves.easeOutBack)
            .fadeIn(duration: 400.ms),
        const SizedBox(height: AppSpacing.lg),
        Text(
              profile.name,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            )
            .animate()
            .slideY(begin: 0.2, end: 0, duration: 400.ms)
            .fadeIn(duration: 400.ms),
        const SizedBox(height: AppSpacing.sm),
        Text(
              profile.email,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            )
            .animate()
            .slideY(begin: 0.2, end: 0, duration: 400.ms, delay: 100.ms)
            .fadeIn(duration: 400.ms),
      ],
    );
  }
}
