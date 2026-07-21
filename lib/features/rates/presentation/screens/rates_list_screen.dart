import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/locale_keys.dart';
import '../../../../shared/extensions/build_context_theme_ext.dart';
import '../../../../shared/formatters/failure_message_mapper.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../domain/entities/currency_rate.dart';
import '../cubit/rates_list_cubit.dart';
import '../cubit/rates_list_state.dart';
import '../widgets/rate_tile.dart';

class RatesListScreen extends StatelessWidget {
  const RatesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.rates_title.tr())),
      body: BlocBuilder<RatesListCubit, RatesListState>(
        builder: (context, state) => switch (state) {
          RatesListInitial() || RatesListLoading() => LoadingView(
            message: LocaleKeys.common_loading.tr(),
          ),
          RatesListError(:final failure) => _Refreshable(
            child: ErrorView(
              message: mapFailureToMessage(failure),
              onRetry: () => context.read<RatesListCubit>().load(),
            ),
          ),
          RatesListLoaded(:final rates) when rates.isEmpty => _Refreshable(
            child: EmptyView(message: LocaleKeys.rates_empty.tr()),
          ),
          RatesListLoaded(:final rates) => _RatesList(rates: rates),
        },
      ),
    );
  }
}

class _RatesList extends StatelessWidget {
  const _RatesList({required this.rates});

  final List<CurrencyRate> rates;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<RatesListCubit>().refresh(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: context.spacing.sm),
        itemCount: rates.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (_, index) => RateTile(rate: rates[index]),
      ),
    );
  }
}

class _Refreshable extends StatelessWidget {
  const _Refreshable({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<RatesListCubit>().refresh(),
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: child,
          ),
        ),
      ),
    );
  }
}
