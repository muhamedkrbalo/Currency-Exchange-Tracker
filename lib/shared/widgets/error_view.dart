import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/localization/locale_keys.dart';
import 'app_button.dart';
import 'state_message_view.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.message,
    this.onRetry,
    this.retryLabel,
    this.icon = Icons.error_outline,
  });

  final String message;
  final VoidCallback? onRetry;
  final String? retryLabel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return StateMessageView(
      icon: icon,
      message: message,
      action: onRetry == null
          ? null
          : AppButton(
              label: retryLabel ?? LocaleKeys.common_retry.tr(),
              onPressed: onRetry,
              icon: Icons.refresh,
              expanded: false,
            ),
    );
  }
}
