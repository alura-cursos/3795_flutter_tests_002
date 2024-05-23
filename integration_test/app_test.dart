import "dart:math";

import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_listin/_core/constants/listin_keys.dart";
import "package:flutter_listin/firebase_options.dart";
import "package:flutter_listin/main.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Fluxo de autenticação", () {
    setUp(() async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    });
    testWidgets("Telas de entrar e cadastrar", (tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsNWidgets(2));

      expect(find.text("Entrar"), findsOneWidget);

      await tester
          .tap(find.text("Ainda não tem conta?\nClique aqui para cadastrar."));

      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsNWidgets(4));

      expect(find.text("Cadastrar"), findsOneWidget);
    }, skip: true);

    testWidgets("Cadastrar e deslogar", (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      String name = "Ricarth Lima";
      String email = "ricarth${Random().nextInt(899) + 100}@gmail.com";
      String password = "123321";

      await tester.tap(
        find.byKey(const ValueKey(ListinKeys.authChangeStateButton)),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const ValueKey(ListinKeys.authNameTextField)),
        name,
      );

      await tester.enterText(
        find.byKey(const ValueKey(ListinKeys.authEmailTextField)),
        email,
      );

      await tester.enterText(
        find.byKey(const ValueKey(ListinKeys.authPasswordTextField)),
        password,
      );

      await tester.enterText(
        find.byKey(const ValueKey(ListinKeys.authConfirmPasswordTextField)),
        password,
      );

      await tester.tap(find.byKey(const ValueKey(ListinKeys.authMainButton)));
      await tester.pumpAndSettle();
    });
  });
}
