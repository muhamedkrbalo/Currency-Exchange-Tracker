import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../shared/extensions/build_context_theme_ext.dart';
import '../../domain/entities/currency_rate.dart';
import 'rate_change_chip.dart';

class RateTile extends StatelessWidget {
  const RateTile({super.key, required this.rate, this.onTap});

  final CurrencyRate rate;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final value = NumberFormat('#,##0.####').format(rate.rateInEgp);

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        child: Text(
          rate.code.toUpperCase(),
          style: context.textStyles.labelSmall,
        ),
      ),
      title: Text(rate.name, style: context.textStyles.titleMedium),
      subtitle: Text(
        LocaleKeys.rates_unit_format.tr(
          namedArgs: {'code': rate.code.toUpperCase(), 'value': value},
        ),
        style: context.textStyles.bodySmall,
      ),
      trailing: RateChangeChip(rate: rate),
    );
  }
}
