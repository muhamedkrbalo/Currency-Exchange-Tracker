import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/localization/locale_keys.dart';
import '../extensions/build_context_theme_ext.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key, this.message, this.lastUpdatedLabel});

  final String? message;
  final String? lastUpdatedLabel;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    final background = context.appColors.offlineBanner;
    final foreground =
        ThemeData.estimateBrightnessForColor(background) == Brightness.dark
            ? Colors.white
            : Colors.black87;
    final textStyle = context.textStyles.bodySmall?.copyWith(color: foreground);

    return Material(
      color: background,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.md,
          vertical: spacing.sm,
        ),
        child: Row(
          children: [
            Icon(Icons.cloud_off, size: spacing.md, color: foreground),
            SizedBox(width: spacing.sm),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message ?? LocaleKeys.offline_banner.tr(), style: textStyle),
                  if (lastUpdatedLabel != null)
                    Text(lastUpdatedLabel!, style: textStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
