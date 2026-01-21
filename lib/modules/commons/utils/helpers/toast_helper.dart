import "package:flutter/material.dart";

import "../resources/theme/app_theme.dart";

enum ToastStatus { success, error, warning, info }

class ToastHelper {
  static void _show(
    BuildContext context, {
    required String message,
    ToastStatus status = ToastStatus.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    final (
      Color backgroundColor,
      Color foregroundColor,
      IconData icon,
    ) = switch (status) {
      ToastStatus.success => (
        colorScheme.primaryContainer,
        colorScheme.onPrimaryContainer,
        Icons.check_circle_outline,
      ),
      ToastStatus.error => (
        colorScheme.errorContainer,
        colorScheme.onErrorContainer,
        Icons.error_outline,
      ),
      ToastStatus.warning => (
        colorScheme.tertiaryContainer,
        colorScheme.onTertiaryContainer,
        Icons.warning_amber_outlined,
      ),
      ToastStatus.info => (
        colorScheme.secondaryContainer,
        colorScheme.onSecondaryContainer,
        Icons.info_outline,
      ),
    };

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: foregroundColor, size: AppSizes.iconMd),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(message, style: TextStyle(color: foregroundColor)),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),
        duration: duration,
        margin: const EdgeInsets.all(AppSpacing.md),
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    _show(context, message: message, status: ToastStatus.success);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message: message, status: ToastStatus.error);
  }

  static void showWarning(BuildContext context, String message) {
    _show(context, message: message, status: ToastStatus.warning);
  }

  static void showInfo(BuildContext context, String message) {
    _show(context, message: message);
  }
}
