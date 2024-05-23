import 'package:flutter/material.dart';
import 'package:flutter_listin/authentication/screens/auth_screen.dart';
import 'package:flutter_listin/authentication/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../components/dialog_remove_account_test.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
  });

  Future<void> pumpAuthScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AuthScreen(authService: mockAuthService),
      ),
    );
  }

  testWidgets('Verificar elementos da tela de login',
      (WidgetTester tester) async {
    await pumpAuthScreen(tester);

    // Verificar se os campos de email e senha estão presentes
    expect(find.byType(TextFormField), findsNWidgets(2));

    // Verificar se o botão de login está presente
    expect(find.text('Entrar'), findsOneWidget);
  });

  testWidgets('Alternar para a tela de cadastro', (WidgetTester tester) async {
    await pumpAuthScreen(tester);

    // Alternar para a tela de cadastro
    await tester.tap(
      find.text("Ainda não tem conta?\nClique aqui para cadastrar."),
    );
    await tester.pumpAndSettle();

    // Verificar se os campos de nome, email, senha e confirmação de senha estão presentes
    expect(find.byType(TextFormField), findsNWidgets(4));

    // Verificar se o botão de cadastro está presente
    expect(find.text('Cadastrar'), findsOneWidget);
  });

  testWidgets('Validação do formulário de login', (WidgetTester tester) async {
    await pumpAuthScreen(tester);

    // Deixar os campos vazios e tentar fazer login
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();

    // Verificar se as mensagens de erro são exibidas
    expect(find.text('O valor de e-mail deve ser preenchido'), findsOneWidget);
    expect(find.text('Insira uma senha válida'), findsOneWidget);
  });

  testWidgets('Validação do formulário de cadastro',
      (WidgetTester tester) async {
    await pumpAuthScreen(tester);

    // Alternar para a tela de cadastro
    await tester
        .tap(find.text('Ainda não tem conta?\nClique aqui para cadastrar.'));
    await tester.pumpAndSettle();

    // Deixar os campos vazios e tentar cadastrar
    await tester.tap(find.text('Cadastrar'));
    await tester.pumpAndSettle();

    // Verificar se as mensagens de erro são exibidas
    expect(find.text('Insira um nome maior'), findsOneWidget);
    expect(find.text('O valor de e-mail deve ser preenchido'), findsOneWidget);
    expect(find.text('Insira uma senha válida'), findsOneWidget);
    expect(find.text('Insira uma confirmação de senha válida'), findsOneWidget);
  });
}
