import 'package:flutter/material.dart';

import '../extensions/build_context_theme_ext.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final Widget child;
    if (isLoading) {
      final size = context.spacing.md;
      child = SizedBox(
        height: size,
        width: size,
        child: const CircularProgressIndicator(strokeWidth: 2),
      );
    } else if (icon == null) {
      child = Text(label);
    } else {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(width: context.spacing.sm),
          Text(label),
        ],
      );
    }

    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: child,
    );

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
