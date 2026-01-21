part of "../profile_view.dart";

class _ProfileStatsSection extends StatelessWidget {
  final ProfileEntity profile;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _ProfileStatsSection({
    required this.profile,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  label: "Posts",
                  value: "${profile.postCount}",
                  theme: theme,
                  colorScheme: colorScheme,
                ),
                _StatItem(
                  label: "Idade",
                  value: "${profile.age}",
                  theme: theme,
                  colorScheme: colorScheme,
                ),
              ],
            ),
          ),
        )
        .animate()
        .slideY(begin: 0.2, end: 0, duration: 400.ms, delay: 200.ms)
        .fadeIn(duration: 400.ms);
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _StatItem({
    required this.label,
    required this.value,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
