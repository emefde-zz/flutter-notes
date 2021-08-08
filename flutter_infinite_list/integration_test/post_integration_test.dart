import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_infinite_list/main.dart' as app; // app under tests

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidget();
}

void testWidget() {
  group('small integration test', () {
    testWidgets('test views load properly', (WidgetTester tester) async {
      app.main(); // runs the app

      await tester.pumpAndSettle();

      final Finder text = find.text('Posts');

      expect(text, findsOneWidget);
    });
  });
}
