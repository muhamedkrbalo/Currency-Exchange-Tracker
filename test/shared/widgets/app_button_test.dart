import 'package:currency_exchange_tracker/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/pump_themed.dart';

void main() {
  testWidgets('renders the label', (tester) async {
    await tester.pumpThemed(const AppButton(label: 'Retry'));

    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('invokes onPressed when tapped', (tester) async {
    var taps = 0;
    await tester.pumpThemed(
      AppButton(label: 'Retry', onPressed: () => taps++),
    );

    await tester.tap(find.byType(ElevatedButton));

    expect(taps, 1);
  });

  testWidgets('shows a spinner and disables the button while loading',
      (tester) async {
    var taps = 0;
    await tester.pumpThemed(
      AppButton(label: 'Retry', isLoading: true, onPressed: () => taps++),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Retry'), findsNothing);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
    expect(taps, 0);
  });
}
