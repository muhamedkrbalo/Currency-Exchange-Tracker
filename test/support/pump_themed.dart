import 'package:currency_exchange_tracker/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpThemedX on WidgetTester {
  Future<void> pumpThemed(Widget child) {
    return pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(body: child),
      ),
    );
  }
}
