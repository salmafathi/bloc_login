import 'package:bloc_login/data/constants/keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:bloc_login/main.dart' as app;


void main() {
  group('App test', (){
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('welcome test', (WidgetTester tester) async{
      app.main();
      tester.pumpAndSettle();
      final Finder registerButton = find.byKey(const Key(REGISTER_KEY));
      final Finder loginButton = find.byKey(const Key(LOGIN_KEY));
      tester.tap(registerButton);
      tester.pumpAndSettle();

      //tester.enterText(finder, text)
    },timeout: Timeout.none);
  });

}
