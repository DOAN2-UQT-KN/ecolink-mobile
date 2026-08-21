import 'package:flutter_test/flutter_test.dart';
import 'package:ecolink_mobile/main.dart';

void main() {
  testWidgets('EcoLink app boots', (tester) async {
    await tester.pumpWidget(const EcoLinkApp());
    await tester.pump();
    expect(find.text('EcoLink'), findsWidgets);
  });
}
