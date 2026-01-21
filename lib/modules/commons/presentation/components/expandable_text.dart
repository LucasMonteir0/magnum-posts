import "package:flutter/material.dart";

import "../../utils/resources/theme/app_theme.dart";

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLength;
  final TextStyle? style;
  final String expandText;
  final String collapseText;

  const ExpandableText({
    required this.text,
    super.key,
    this.maxLength = 100,
    this.style,
    this.expandText = "Ver mais",
    this.collapseText = "Ver menos",
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final shouldTruncate = widget.text.length > widget.maxLength;

    final displayText = _isExpanded || !shouldTruncate
        ? widget.text
        : "${widget.text.substring(0, widget.maxLength)}...";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayText,
          style:
              widget.style ??
              theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
        if (shouldTruncate)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xs),
              child: Text(
                _isExpanded ? widget.collapseText : widget.expandText,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
