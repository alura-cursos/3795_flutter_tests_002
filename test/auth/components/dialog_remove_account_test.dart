import 'package:flutter/material.dart';
import 'package:flutter_listin/authentication/components/dialog_remove_account.dart';
import 'package:flutter_listin/authentication/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dialog_remove_account_test.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
  });

  Future<void> pumpDialog(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showRemoveAccountPasswordConfirmationDialog(
                  context: context,
                  email: 'test@test.com',
                  authService: mockAuthService,
                );
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();
  }

  testWidgets('A caixa de diálogo é exibida com os elementos corretos',
      (WidgetTester tester) async {
    await pumpDialog(tester);

    // Verificar se o título do diálogo está correto
    expect(find.text('Deseja remover a conta com o e-mail test@test.com?'),
        findsOneWidget);

    // Verificar se o campo de senha está presente
    expect(find.byType(TextFormField), findsOneWidget);

    // Verificar se o botão EXCLUIR CONTA está presente
    expect(find.text('EXCLUIR CONTA'), findsOneWidget);
  });

  testWidgets('A remoção da conta é chamada com a senha correta',
      (WidgetTester tester) async {
    when(mockAuthService.removeAccount(senha: anyNamed('senha')))
        .thenAnswer((_) async => null);

    await pumpDialog(tester);

    // Inserir senha no campo de texto
    await tester.enterText(find.byType(TextFormField), 'password123');

    // Pressionar o botão EXCLUIR CONTA
    await tester.tap(find.text('EXCLUIR CONTA'));
    await tester.pumpAndSettle();

    // Verificar se a função removeAccount foi chamada com a senha correta
    verify(mockAuthService.removeAccount(senha: 'password123')).called(1);
  });
}
