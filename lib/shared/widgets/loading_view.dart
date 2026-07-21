import 'package:flutter/material.dart';

import '../extensions/build_context_theme_ext.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            SizedBox(height: context.spacing.md),
            Text(message!, style: context.textStyles.bodyMedium),
          ],
        ],
      ),
    );
  }
}
