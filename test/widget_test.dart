import 'package:flutter_test/flutter_test.dart';

import 'package:victus_one_v1/app.dart';

void main() {
  testWidgets('Home shows dashboard greeting', (WidgetTester tester) async {
    await tester.pumpWidget(const VictusApp());
    await tester.pumpAndSettle();
    expect(find.text('Good Morning'), findsOneWidget);
  });
}
