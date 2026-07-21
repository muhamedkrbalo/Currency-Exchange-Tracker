import 'package:currency_exchange_tracker/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';

import '../../support/pump_themed.dart';

void main() {
  testWidgets('renders a shimmer effect', (tester) async {
    await tester.pumpThemed(const ShimmerBox(width: 100, height: 20));
    await tester.pump();

    expect(find.byType(Shimmer), findsOneWidget);
  });

  testWidgets('applies the requested size', (tester) async {
    await tester.pumpThemed(const ShimmerBox(width: 100, height: 20));
    await tester.pump();

    final container = tester.widget<Container>(find.byType(Container));
    expect(container.constraints?.maxWidth, 100);
    expect(container.constraints?.maxHeight, 20);
  });
}
