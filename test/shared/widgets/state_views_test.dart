import 'package:currency_exchange_tracker/shared/widgets/app_button.dart';
import 'package:currency_exchange_tracker/shared/widgets/empty_view.dart';
import 'package:currency_exchange_tracker/shared/widgets/error_view.dart';
import 'package:currency_exchange_tracker/shared/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/pump_themed.dart';

void main() {
  group('LoadingView', () {
    testWidgets('always shows a progress indicator', (tester) async {
      await tester.pumpThemed(const LoadingView());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows the optional message', (tester) async {
      await tester.pumpThemed(const LoadingView(message: 'Loading rates'));

      expect(find.text('Loading rates'), findsOneWidget);
    });
  });

  group('EmptyView', () {
    testWidgets('shows the message and default icon', (tester) async {
      await tester.pumpThemed(const EmptyView(message: 'Nothing here'));

      expect(find.text('Nothing here'), findsOneWidget);
      expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
    });
  });

  group('ErrorView', () {
    testWidgets('shows the message and no retry action by default',
        (tester) async {
      await tester.pumpThemed(const ErrorView(message: 'Boom'));

      expect(find.text('Boom'), findsOneWidget);
      expect(find.byType(AppButton), findsNothing);
    });

    testWidgets('shows a retry button that fires the callback', (tester) async {
      var retried = 0;
      await tester.pumpThemed(
        ErrorView(
          message: 'Boom',
          retryLabel: 'Retry',
          onRetry: () => retried++,
        ),
      );

      expect(find.byType(AppButton), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));

      expect(retried, 1);
    });
  });
}
