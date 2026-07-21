import 'package:currency_exchange_tracker/shared/widgets/offline_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/pump_themed.dart';

void main() {
  testWidgets('shows the provided message', (tester) async {
    await tester.pumpThemed(const OfflineBanner(message: 'You are offline'));

    expect(find.text('You are offline'), findsOneWidget);
    expect(find.byIcon(Icons.cloud_off), findsOneWidget);
  });

  testWidgets('shows the last-updated label when provided', (tester) async {
    await tester.pumpThemed(
      const OfflineBanner(
        message: 'You are offline',
        lastUpdatedLabel: 'Last updated today',
      ),
    );

    expect(find.text('Last updated today'), findsOneWidget);
  });

  testWidgets('omits the last-updated label when absent', (tester) async {
    await tester.pumpThemed(const OfflineBanner(message: 'You are offline'));

    expect(find.text('Last updated today'), findsNothing);
  });
}
