part of "../profile_view.dart";

class _ProfileInterestsSection extends StatelessWidget {
  final List<String> interests;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _ProfileInterestsSection({
    required this.theme,
    required this.colorScheme,
    required this.interests,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Gostos",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: interests.map((interest) {
                return Chip(
                  label: Text(interest),
                  side: BorderSide(
                    color: colorScheme.primary.withValues(alpha: 0.6),
                  ),
                  backgroundColor: colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.3),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary.withValues(alpha: 0.6),
                  ),
                );
              }).toList(),
            ),
          ],
        )
        .animate()
        .slideY(begin: 0.2, end: 0, duration: 400.ms, delay: 300.ms)
        .fadeIn(duration: 400.ms);
  }
}
