import "package:flutter/material.dart";

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double radius;
  final BoxFit fit;

  const AppNetworkImage({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.radius = 0,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Container(
            width: width,
            height: height,
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            child: const Center(child: CircularProgressIndicator()),
          );
        },
        errorBuilder: (context, error, stackTrace) => Container(
          width: width,
          height: height,
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          child: Icon(Icons.error_outline_rounded, color: colorScheme.error),
        ),
      ),
    );
  }
}
