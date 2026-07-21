import 'package:flutter/widgets.dart';

abstract final class AppBreakpoints {
  const AppBreakpoints._();

  static const double tablet = 600;
  static const double desktop = 1024;
}

extension ResponsiveContextX on BuildContext {
  bool get isTablet =>
      MediaQuery.sizeOf(this).shortestSide >= AppBreakpoints.tablet;

  bool get isDesktop => MediaQuery.sizeOf(this).width >= AppBreakpoints.desktop;
}
