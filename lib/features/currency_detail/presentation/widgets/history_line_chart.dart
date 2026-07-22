import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../shared/extensions/build_context_theme_ext.dart';
import '../../../rates/domain/entities/historical_rate.dart';

class HistoryLineChart extends StatelessWidget {
  const HistoryLineChart({super.key, required this.history});

  final List<HistoricalRate> history;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spots = [
      for (var i = 0; i < history.length; i++)
        FlSpot(i.toDouble(), history[i].rateInEgp),
    ];

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(show: false),
        lineTouchData: const LineTouchData(enabled: true),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: colors.chartLine,
            barWidth: 3,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [colors.chartGradientStart, colors.chartGradientEnd],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
