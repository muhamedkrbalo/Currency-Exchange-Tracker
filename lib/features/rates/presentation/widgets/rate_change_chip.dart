import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../shared/extensions/build_context_theme_ext.dart';
import '../../../../shared/theme/app_radii.dart';
import '../../domain/entities/currency_rate.dart';

class RateChangeChip extends StatelessWidget {
  const RateChangeChip({super.key, required this.rate});

  final CurrencyRate rate;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.spacing;
    final change = rate.absoluteChange;

    final (Color color, IconData icon) = switch (change) {
      < 0 => (colors.success, Icons.arrow_downward),
      > 0 => (colors.danger, Icons.arrow_upward),
      _ => (Theme.of(context).colorScheme.onSurfaceVariant, Icons.remove),
    };

    final percent = NumberFormat('0.00').format(rate.percentChange.abs());

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.sm,
        vertical: spacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: AppRadii.radiusFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: spacing.md, color: color),
          SizedBox(width: spacing.xs),
          Text(
            '$percent%',
            style: context.textStyles.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
