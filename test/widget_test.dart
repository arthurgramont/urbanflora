import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urban_flora/main.dart';

void main() {
  testWidgets('UrbanFloraApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: UrbanFloraApp(),
      ),
    );
  });
}