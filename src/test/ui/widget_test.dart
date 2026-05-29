import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:salvando_vidas/data/services/user_service.dart';
import 'package:salvando_vidas/routing/routes.dart';
import 'package:salvando_vidas/ui/home/admin_page.dart';
import 'package:salvando_vidas/ui/home/cadastros_page.dart';
import 'package:salvando_vidas/ui/home/home_page.dart';
import 'package:salvando_vidas/ui/login/views/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockUserService extends Mock implements UserService {}

class MockLogger extends Mock implements Logger {}

class _FakeSupabaseClient extends Fake implements SupabaseClient {}

class FakeUserService extends UserService {
  FakeUserService() : super(_FakeSupabaseClient());

  bool admin = false;
  bool loggedIn = true;
  bool logoutCalled = false;
  Future<bool> Function(String email, String password)? loginHandler;
  Future<bool> Function()? isLoggedInHandler;

  @override
  Future<bool> login(String email, String password) {
    final handler = loginHandler;
    if (handler != null) {
      return handler(email, password);
    }

    return Future<bool>.value(false);
  }

  @override
  void logout() {
    logoutCalled = true;
  }

  @override
  Future<bool> isLoggedIn() {
    final handler = isLoggedInHandler;
    if (handler != null) {
      return handler();
    }

    return Future<bool>.value(loggedIn);
  }

  @override
  bool get isAdmin => admin;
}

GoRouter _buildRouter(String initialLocation) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(path: Routes.login, builder: (context, state) => const LoginPage()),
      GoRoute(path: Routes.home, builder: (context, state) => const HomePage()),
      GoRoute(path: Routes.admin, builder: (context, state) => const AdminPage()),
      GoRoute(
        path: Routes.cadastros,
        builder: (context, state) => const CadastrosPage(),
      ),
    ],
  );
}

Future<void> _pumpApp(
  WidgetTester tester, {
  required UserService userService,
  Logger? logger,
  required String initialLocation,
}) async {
  final providers = [
    Provider<UserService>.value(value: userService),
    if (logger != null) Provider<Logger>.value(value: logger),
  ];

  await tester.pumpWidget(
    MultiProvider(
      providers: providers,
      child: MaterialApp.router(
        routerConfig: _buildRouter(initialLocation),
      ),
    ),
  );

  await tester.pumpAndSettle();
}

void main() {
  testWidgets('LoginPage exibe os elementos principais', (tester) async {
    final userService = FakeUserService();
    final logger = MockLogger();

    await _pumpApp(
      tester,
      userService: userService,
      logger: logger,
      initialLocation: Routes.login,
    );

    expect(find.text('Logo'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });

  testWidgets('LoginPage navega para home ao autenticar', (tester) async {
    final userService = FakeUserService();
    final logger = MockLogger();

    userService.loginHandler = (email, password) async =>
        email == 'teste@teste.com' && password == 'SenhaTeste';

    await _pumpApp(
      tester,
      userService: userService,
      logger: logger,
      initialLocation: Routes.login,
    );

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'teste@teste.com');
    await tester.pump();
    await tester.enterText(fields.at(1), 'SenhaTeste');
    await tester.pump();

    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();

    expect(find.text('Página inicial'), findsOneWidget);
    expect(find.text('Cadastros'), findsOneWidget);
  });

  testWidgets('LoginPage registra erro quando a autenticação falha', (
    tester,
  ) async {
    final userService = FakeUserService();
    final logger = MockLogger();

    userService.loginHandler = (email, password) {
      throw AuthApiException('Usuário inválido');
    };

    await _pumpApp(
      tester,
      userService: userService,
      logger: logger,
      initialLocation: Routes.login,
    );

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'teste@teste.com');
    await tester.pump();
    await tester.enterText(fields.at(1), 'SenhaTeste');
    await tester.pump();

    await tester.tap(find.text('Entrar'));
    await tester.pump();

    verify(logger.e('Erro ao autenticar', error: anyNamed('error'))).called(1);
    expect(find.text('Página inicial'), findsNothing);
  });

  testWidgets('HomePage mostra a mensagem de perfil comum e abre cadastros', (
    tester,
  ) async {
    final userService = FakeUserService();
    final logger = MockLogger();

    userService.admin = false;

    await _pumpApp(
      tester,
      userService: userService,
      logger: logger,
      initialLocation: Routes.home,
    );

    expect(find.text('Página inicial'), findsOneWidget);
    expect(find.text('Seu perfil não é administrador.'), findsOneWidget);
    expect(find.text('A seção de administrador fica visível apenas para login ADM.'), findsOneWidget);
    expect(find.byIcon(Icons.admin_panel_settings_outlined), findsNothing);

    await tester.tap(find.byIcon(Icons.folder_open_outlined));
    await tester.pumpAndSettle();

    expect(
      find.text('Área simples para organizar acessos rápidos e cadastrar alunos.'),
      findsOneWidget,
    );
  });

  testWidgets('HomePage mostra a área de administrador para o perfil ADM', (
    tester,
  ) async {
    final userService = FakeUserService();
    final logger = MockLogger();

    userService.admin = true;

    await _pumpApp(
      tester,
      userService: userService,
      logger: logger,
      initialLocation: Routes.home,
    );

    expect(find.text('Escolha uma área para acessar.'), findsOneWidget);
    expect(find.byIcon(Icons.admin_panel_settings_outlined), findsOneWidget);

    await tester.tap(find.byIcon(Icons.admin_panel_settings_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Painel do Administrador'), findsOneWidget);
  });

  testWidgets('CadastrosPage permite cadastrar um aluno', (tester) async {
    final userService = FakeUserService();
    final logger = MockLogger();

    await _pumpApp(
      tester,
      userService: userService,
      logger: logger,
      initialLocation: Routes.cadastros,
    );

    expect(find.text('Cadastros'), findsOneWidget);
    expect(find.text('Cadastrar alunos'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.expand_more));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Maria Silva');
    await tester.enterText(fields.at(1), '01/01/2015');
    await tester.enterText(fields.at(2), '123456');
    await tester.enterText(fields.at(3), 'João Silva');
    await tester.enterText(fields.at(4), '11999999999');
    await tester.enterText(fields.at(5), 'responsavel@example.com');

    await tester.ensureVisible(find.text('Salvar aluno'));
    await tester.tap(find.text('Salvar aluno'));
    await tester.pump();

    expect(find.text('Aluno e responsável cadastrados.'), findsOneWidget);
  });

  testWidgets('AdminPage permite expandir e salvar o cadastro de alunos', (
    tester,
  ) async {
    final userService = FakeUserService();
    final logger = MockLogger();

    await _pumpApp(
      tester,
      userService: userService,
      logger: logger,
      initialLocation: Routes.admin,
    );

    expect(find.text('Painel do Administrador'), findsOneWidget);
    expect(find.text('Cadastrar voluntários'), findsOneWidget);
    expect(find.text('Cadastrar turmas'), findsOneWidget);
    expect(find.text('Cadastrar alunos'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.byIcon(Icons.expand_more).at(2),
      300,
    );
    await tester.tap(find.byIcon(Icons.expand_more).at(2));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Maria Silva');
    await tester.enterText(fields.at(1), '01/01/2015');
    await tester.enterText(fields.at(2), '123456');
    await tester.enterText(fields.at(3), 'João Silva');
    await tester.enterText(fields.at(4), '11999999999');
    await tester.enterText(fields.at(5), 'responsavel@example.com');

    await tester.ensureVisible(find.text('Salvar aluno'));
    await tester.tap(find.text('Salvar aluno'));
    await tester.pump();

    expect(find.text('Aluno e responsável cadastrados.'), findsOneWidget);
  });
}
