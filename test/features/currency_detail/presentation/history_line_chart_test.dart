import 'package:currency_exchange_tracker/features/currency_detail/presentation/widgets/history_line_chart.dart';
import 'package:currency_exchange_tracker/features/rates/domain/entities/historical_rate.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/pump_themed.dart';

List<HistoricalRate> _series(List<double> rates) => [
  for (var i = 0; i < rates.length; i++)
    HistoricalRate(date: DateTime(2026, 7, 15 + i), rateInEgp: rates[i]),
];

Future<void> _pumpChart(WidgetTester tester, List<HistoricalRate> history) =>
    tester.pumpThemed(
      SizedBox(height: 240, child: HistoryLineChart(history: history)),
    );

void main() {
  testWidgets('renders a line chart for a multi-day series', (tester) async {
    await _pumpChart(tester, _series([50, 51, 49, 52, 53, 51, 54]));
    expect(find.byType(LineChart), findsOneWidget);
  });

  testWidgets('renders without clipping a flat series', (tester) async {
    await _pumpChart(tester, _series([50, 50, 50]));
    expect(find.byType(LineChart), findsOneWidget);
  });

  testWidgets('renders a single data point without error', (tester) async {
    await _pumpChart(tester, _series([50]));
    expect(find.byType(LineChart), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
