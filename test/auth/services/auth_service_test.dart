import 'package:flutter_listin/authentication/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_service_test.mocks.dart';

@GenerateMocks([FirebaseAuth, UserCredential, User])
void main() {
  late AuthService authService;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    authService = AuthService(firebaseAuthObject: mockFirebaseAuth);
  });

  group('AuthService', () {
    test('login com sucesso', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockUserCredential);

      final result =
          await authService.login(email: 'test@test.com', senha: 'password123');
      expect(result, isNull);
    });

    test('login com email não cadastrado', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(FirebaseAuthException(code: 'user-not-found'));

      final result =
          await authService.login(email: 'test@test.com', senha: 'password123');
      expect(result, 'O e-mail não está cadastrado.');
    });

    test('signup com sucesso', () async {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);

      final result = await authService.signup(
          email: 'test@test.com', senha: 'password123', nome: 'Test User');
      verify(mockUser.updateDisplayName('Test User')).called(1);
      expect(result, isNull);
    });

    test('signup com email já em uso', () async {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

      final result = await authService.signup(
          email: 'test@test.com', senha: 'password123', nome: 'Test User');
      expect(result, 'O e-mail já está em uso.');
    });

    test('createNewPassword com sucesso', () async {
      final result =
          await authService.createNewPassword(email: 'test@test.com');
      expect(result, isNull);
    });

    test('createNewPassword com email não cadastrado', () async {
      when(mockFirebaseAuth.sendPasswordResetEmail(email: anyNamed('email')))
          .thenThrow(FirebaseAuthException(code: 'user-not-found'));

      final result =
          await authService.createNewPassword(email: 'test@test.com');
      expect(result, 'E-mail não cadastrado.');
    });

    test('logout com sucesso', () async {
      final result = await authService.logout();
      expect(result, isNull);
    });

    test('removeAccount com sucesso', () async {
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.email).thenReturn('test@test.com');
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);

      final result = await authService.removeAccount(senha: 'password123');
      expect(result, isNull);
    });
  });
}
