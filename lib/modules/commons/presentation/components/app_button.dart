import "package:flutter/material.dart";

import "../../utils/resources/theme/app_theme.dart";

enum AppButtonVariant { filled, outlined, text }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool iconOnRight;
  final bool expanded;

  const AppButton({
    required this.text,
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.variant = AppButtonVariant.filled,
    this.icon,
    this.iconOnRight = false,
    this.expanded = true,
  });

  const AppButton.filled({
    required this.text,
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.iconOnRight = false,
    this.expanded = true,
  }) : variant = AppButtonVariant.filled;

  const AppButton.outlined({
    required this.text,
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.iconOnRight = false,
    this.expanded = true,
  }) : variant = AppButtonVariant.outlined;

  const AppButton.text({
    required this.text,
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.iconOnRight = false,
    this.expanded = false,
  }) : variant = AppButtonVariant.text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget loadingWidget = SizedBox(
      height: AppSizes.iconSm,
      width: AppSizes.iconSm,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: variant == AppButtonVariant.filled
            ? colorScheme.onPrimary
            : colorScheme.primary,
      ),
    );

    Widget child = isLoading ? loadingWidget : Text(text);

    if (icon != null && !isLoading) {
      child = iconOnRight
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(text),
                const SizedBox(width: AppSpacing.xs),
                Icon(icon, size: AppSizes.iconSm),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: AppSizes.iconSm),
                const SizedBox(width: AppSpacing.xs),
                Text(text),
              ],
            );
    }

    Widget button;
    switch (variant) {
      case AppButtonVariant.filled:
        button = FilledButton(
          onPressed: isLoading ? null : onPressed,
          child: child,
        );
      case AppButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          child: child,
        );
      case AppButtonVariant.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          child: child,
        );
    }

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
