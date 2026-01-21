import "package:flutter/material.dart";

import "../../utils/resources/theme/app_theme.dart";

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
