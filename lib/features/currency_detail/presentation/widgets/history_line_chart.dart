import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../shared/extensions/build_context_theme_ext.dart';
import '../../../rates/domain/entities/historical_rate.dart';

class HistoryLineChart extends StatelessWidget {
  const HistoryLineChart({super.key, required this.history});

  final List<HistoricalRate> history;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final scheme = Theme.of(context).colorScheme;
    final labelStyle = context.textStyles.labelSmall?.copyWith(
      color: scheme.onSurfaceVariant,
    );

    final lastIndex = history.length - 1;
    final bounds = _Bounds.fromHistory(history);
    final spots = [
      for (var i = 0; i < history.length; i++)
        FlSpot(i.toDouble(), history[i].rateInEgp),
    ];

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: lastIndex.toDouble(),
        minY: bounds.min,
        maxY: bounds.max,
        clipData: const FlClipData.all(),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: bounds.step,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: scheme.outlineVariant, strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 48,
              interval: bounds.step,
              getTitlesWidget: (value, meta) {
                if (value == meta.min || value == meta.max) {
                  return const SizedBox.shrink();
                }
                return SideTitleWidget(
                  meta: meta,
                  child: Text(_formatRate(value), style: labelStyle),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: _bottomInterval(history.length),
              getTitlesWidget: (value, meta) {
                final index = value.round();
                if (index < 0 || index >= history.length) {
                  return const SizedBox.shrink();
                }
                return SideTitleWidget(
                  meta: meta,
                  child: Text(
                    DateFormat.Md().format(history[index].date),
                    style: labelStyle,
                  ),
                );
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          touchSpotThreshold: 24,
          getTouchedSpotIndicator: (barData, indexes) => [
            for (final _ in indexes)
              TouchedSpotIndicatorData(
                FlLine(color: colors.chartLine, strokeWidth: 1),
                FlDotData(
                  getDotPainter: (spot, _, _, _) => FlDotCirclePainter(
                    radius: 5,
                    color: colors.chartLine,
                    strokeWidth: 2,
                    strokeColor: scheme.surface,
                  ),
                ),
              ),
          ],
          touchTooltipData: LineTouchTooltipData(
            tooltipBorderRadius: BorderRadius.circular(8),
            tooltipPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipColor: (_) => scheme.inverseSurface,
            getTooltipItems: (touchedSpots) => [
              for (final spot in touchedSpots)
                LineTooltipItem(
                  '${DateFormat.yMMMd().format(history[spot.x.round()].date)}\n'
                  '${_formatRate(spot.y)} EGP',
                  context.textStyles.labelMedium!.copyWith(
                    color: scheme.onInverseSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            preventCurveOverShooting: true,
            barWidth: 3,
            color: colors.chartLine,
            dotData: FlDotData(
              show: true,
              checkToShowDot: (spot, _) => spot.x == lastIndex,
              getDotPainter: (spot, _, _, _) => FlDotCirclePainter(
                radius: 4,
                color: colors.chartLine,
                strokeWidth: 2,
                strokeColor: scheme.surface,
              ),
            ),
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

  static double _bottomInterval(int length) =>
      length <= 7 ? 1 : (length / 6).ceilToDouble();
}

String _formatRate(double value) => value.abs() >= 1
    ? NumberFormat('#,##0.00').format(value)
    : NumberFormat('0.0000').format(value);

class _Bounds {
  const _Bounds({required this.min, required this.max, required this.step});

  final double min;
  final double max;
  final double step;

  factory _Bounds.fromHistory(List<HistoricalRate> history) {
    final values = history.map((point) => point.rateInEgp);
    final lowest = values.reduce(math.min);
    final highest = values.reduce(math.max);
    final span = highest - lowest;
    // Pad a flat/near-flat series so the line isn't clipped to the edges.
    final padding = span == 0
        ? math.max(highest.abs() * 0.05, 0.01)
        : span * 0.15;
    final min = lowest - padding;
    final max = highest + padding;
    return _Bounds(min: min, max: max, step: (max - min) / 2);
  }
}
