import 'package:flutter/material.dart';

import '../extensions/build_context_theme_ext.dart';

class StateMessageView extends StatelessWidget {
  const StateMessageView({
    super.key,
    required this.icon,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: spacing.xxl,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: spacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textStyles.bodyMedium,
            ),
            if (action != null) ...[
              SizedBox(height: spacing.lg),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
