import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../shared/extensions/build_context_theme_ext.dart';
import '../../../../shared/formatters/failure_message_mapper.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../rates/domain/entities/historical_rate.dart';
import '../cubit/currency_detail_cubit.dart';
import '../cubit/currency_detail_state.dart';
import '../widgets/currency_history_summary.dart';
import '../widgets/history_line_chart.dart';

class CurrencyDetailScreen extends StatelessWidget {
  const CurrencyDetailScreen({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.detail_title.tr(namedArgs: {'code': code.toUpperCase()}),
        ),
      ),
      body: BlocBuilder<CurrencyDetailCubit, CurrencyDetailState>(
        builder: (context, state) => switch (state) {
          CurrencyDetailInitial() ||
          CurrencyDetailLoading() => const _DetailShimmer(),
          CurrencyDetailError(:final failure) => ErrorView(
            message: mapFailureToMessage(failure),
            onRetry: () => context.read<CurrencyDetailCubit>().load(code),
          ),
          CurrencyDetailLoaded(:final history) when history.isEmpty =>
            EmptyView(message: LocaleKeys.detail_chart_empty.tr()),
          CurrencyDetailLoaded(:final history) => _DetailContent(
            code: code,
            history: history,
          ),
        },
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.code, required this.history});

  final String code;
  final List<HistoricalRate> history;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    return ListView(
      padding: EdgeInsets.all(spacing.md),
      children: [
        _SummaryHeader(code: code, history: history),
        SizedBox(height: spacing.lg),
        Text(
          LocaleKeys.detail_chart_title.tr(),
          style: context.textStyles.titleMedium,
        ),
        SizedBox(height: spacing.md),
        SizedBox(height: 240, child: HistoryLineChart(history: history)),
      ],
    );
  }
}

class _SummaryHeader extends StatelessWidget {
  const _SummaryHeader({required this.code, required this.history});

  final String code;
  final List<HistoricalRate> history;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    final rate = NumberFormat('#,##0.####').format(history.currentRate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.detail_current_rate.tr(),
          style: context.textStyles.labelMedium,
        ),
        SizedBox(height: spacing.xs),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              LocaleKeys.rates_unit_format.tr(
                namedArgs: {'code': code.toUpperCase(), 'value': rate},
              ),
              style: context.textStyles.headlineSmall,
            ),
            const Spacer(),
            _ChangeLabel(history: history),
          ],
        ),
        SizedBox(height: spacing.sm),
        Text(
          LocaleKeys.detail_last_update.tr(),
          style: context.textStyles.labelSmall,
        ),
        Text(
          DateFormat.yMMMd().format(history.lastUpdated),
          style: context.textStyles.bodyMedium,
        ),
      ],
    );
  }
}

class _ChangeLabel extends StatelessWidget {
  const _ChangeLabel({required this.history});

  final List<HistoricalRate> history;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final change = history.dailyChange;
    if (change == null || change == 0) {
      return const SizedBox.shrink();
    }

    final stronger = history.isEgpStrengthening;
    final color = stronger ? colors.success : colors.danger;
    final icon = stronger ? Icons.arrow_downward : Icons.arrow_upward;
    final percent = NumberFormat(
      '0.00',
    ).format(history.dailyChangePercent.abs());

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: context.spacing.md, color: color),
        SizedBox(width: context.spacing.xs),
        Text(
          '$percent%',
          style: context.textStyles.labelLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _DetailShimmer extends StatelessWidget {
  const _DetailShimmer();

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    return ListView(
      padding: EdgeInsets.all(spacing.md),
      children: [
        const ShimmerBox(width: 120),
        SizedBox(height: spacing.sm),
        const ShimmerBox(width: 200, height: 28),
        SizedBox(height: spacing.lg),
        const ShimmerBox(width: 100),
        SizedBox(height: spacing.md),
        const ShimmerBox(height: 240),
      ],
    );
  }
}
