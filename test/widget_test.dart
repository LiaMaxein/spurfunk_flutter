import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tatort_liebe_flutter/app/tatort_liebe_app.dart';

void main() {
  testWidgets('Tatort Liebe app renders home foundation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: TatortLiebeApp()));

    expect(find.text('Tatort Liebe'), findsOneWidget);
    expect(find.text('Enter live experience'), findsOneWidget);
  });
}
