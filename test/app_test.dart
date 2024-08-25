import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_guide/app.dart';
import 'package:pocket_guide/home/home.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(NavBarLayout), findsOneWidget);
    });
  });
}
