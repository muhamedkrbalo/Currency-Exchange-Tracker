import 'package:flutter/material.dart';

abstract final class AppPalette {
  const AppPalette._();

  static const Color seed = Color(0xFF00897B);

  // Semantic: EGP strengthening / weakening against a foreign currency.
  static const Color successLight = Color(0xFF2E7D32);
  static const Color successDark = Color(0xFF66BB6A);
  static const Color dangerLight = Color(0xFFC62828);
  static const Color dangerDark = Color(0xFFEF5350);

  // 7-day chart (fl_chart line + gradient fill).
  static const Color chartLineLight = Color(0xFF00695C);
  static const Color chartLineDark = Color(0xFF4DB6AC);
  static const Color chartGradientStartLight = Color(0x3300695C);
  static const Color chartGradientEndLight = Color(0x0000695C);
  static const Color chartGradientStartDark = Color(0x334DB6AC);
  static const Color chartGradientEndDark = Color(0x004DB6AC);

  // Offline / stale-cache banner.
  static const Color offlineBannerLight = Color(0xFFFFA000);
  static const Color offlineBannerDark = Color(0xFFFFB300);

  // Shimmer loading placeholder.
  static const Color shimmerBaseLight = Color(0xFFE0E0E0);
  static const Color shimmerHighlightLight = Color(0xFFF5F5F5);
  static const Color shimmerBaseDark = Color(0xFF2C2C2C);
  static const Color shimmerHighlightDark = Color(0xFF3A3A3A);
}
