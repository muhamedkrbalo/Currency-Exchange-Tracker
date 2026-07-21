import 'package:currency_exchange_tracker/features/rates/domain/entities/currency_rate.dart';
import 'package:currency_exchange_tracker/features/rates/presentation/widgets/rate_change_chip.dart';
import 'package:currency_exchange_tracker/shared/theme/extensions/app_color_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/pump_themed.dart';

CurrencyRate _rate({required double now, required double previous}) =>
    CurrencyRate(
      code: 'usd',
      name: 'US Dollar',
      rateInEgp: now,
      previousRateInEgp: previous,
      lastUpdated: DateTime(2026, 7, 21),
    );

Icon _icon(WidgetTester tester) => tester.widget<Icon>(
  find.descendant(of: find.byType(RateChangeChip), matching: find.byType(Icon)),
);

void main() {
  group('RateChangeChip color-coding', () {
    testWidgets('EGP strengthening (rate fell) uses success + down arrow', (
      tester,
    ) async {
      await tester.pumpThemed(
        RateChangeChip(rate: _rate(now: 47, previous: 48)),
      );

      final icon = _icon(tester);
      expect(icon.icon, Icons.arrow_downward);
      expect(icon.color, AppColors.light.success);
    });

    testWidgets('EGP weakening (rate rose) uses danger + up arrow', (
      tester,
    ) async {
      await tester.pumpThemed(
        RateChangeChip(rate: _rate(now: 49, previous: 48)),
      );

      final icon = _icon(tester);
      expect(icon.icon, Icons.arrow_upward);
      expect(icon.color, AppColors.light.danger);
    });

    testWidgets('no change uses a neutral flat indicator', (tester) async {
      await tester.pumpThemed(
        RateChangeChip(rate: _rate(now: 48, previous: 48)),
      );

      expect(_icon(tester).icon, Icons.remove);
    });

    testWidgets('renders the absolute percent change', (tester) async {
      await tester.pumpThemed(
        RateChangeChip(rate: _rate(now: 49, previous: 48)),
      );

      // (49 - 48) / 48 * 100 = 2.08%
      expect(find.text('2.08%'), findsOneWidget);
    });
  });
}
