import 'package:flutter/material.dart';

import '../app_colors.dart';


@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.success,
    required this.danger,
    required this.chartLine,
    required this.chartGradientStart,
    required this.chartGradientEnd,
    required this.offlineBanner,
    required this.shimmerBase,
    required this.shimmerHighlight,
  });

  final Color success;
  final Color danger;
  final Color chartLine;
  final Color chartGradientStart;
  final Color chartGradientEnd;
  final Color offlineBanner;
  final Color shimmerBase;
  final Color shimmerHighlight;

  static const AppColors light = AppColors(
    success: AppPalette.successLight,
    danger: AppPalette.dangerLight,
    chartLine: AppPalette.chartLineLight,
    chartGradientStart: AppPalette.chartGradientStartLight,
    chartGradientEnd: AppPalette.chartGradientEndLight,
    offlineBanner: AppPalette.offlineBannerLight,
    shimmerBase: AppPalette.shimmerBaseLight,
    shimmerHighlight: AppPalette.shimmerHighlightLight,
  );

  static const AppColors dark = AppColors(
    success: AppPalette.successDark,
    danger: AppPalette.dangerDark,
    chartLine: AppPalette.chartLineDark,
    chartGradientStart: AppPalette.chartGradientStartDark,
    chartGradientEnd: AppPalette.chartGradientEndDark,
    offlineBanner: AppPalette.offlineBannerDark,
    shimmerBase: AppPalette.shimmerBaseDark,
    shimmerHighlight: AppPalette.shimmerHighlightDark,
  );

  @override
  AppColors copyWith({
    Color? success,
    Color? danger,
    Color? chartLine,
    Color? chartGradientStart,
    Color? chartGradientEnd,
    Color? offlineBanner,
    Color? shimmerBase,
    Color? shimmerHighlight,
  }) {
    return AppColors(
      success: success ?? this.success,
      danger: danger ?? this.danger,
      chartLine: chartLine ?? this.chartLine,
      chartGradientStart: chartGradientStart ?? this.chartGradientStart,
      chartGradientEnd: chartGradientEnd ?? this.chartGradientEnd,
      offlineBanner: offlineBanner ?? this.offlineBanner,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      success: Color.lerp(success, other.success, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      chartLine: Color.lerp(chartLine, other.chartLine, t)!,
      chartGradientStart:
          Color.lerp(chartGradientStart, other.chartGradientStart, t)!,
      chartGradientEnd:
          Color.lerp(chartGradientEnd, other.chartGradientEnd, t)!,
      offlineBanner: Color.lerp(offlineBanner, other.offlineBanner, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight:
          Color.lerp(shimmerHighlight, other.shimmerHighlight, t)!,
    );
  }
}
