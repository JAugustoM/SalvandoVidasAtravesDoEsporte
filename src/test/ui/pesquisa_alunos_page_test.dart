import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/domain/aluno/aluno_mock.dart';
import 'package:salvando_vidas/ui/Pesquisar-editar-dados-Aluno/views/pesquisa_alunos_page.dart';

import 'pesquisa_alunos_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AlunoService>()])
void main() {
  late MockAlunoService mockAlunoService;

  setUp(() {
    mockAlunoService = MockAlunoService();
  });

  group('Caixa Preta - PesquisaAlunosPage', () {
    testWidgets('Deve filtrar a lista de alunos corretamente ao digitar', (WidgetTester tester) async {
      when(mockAlunoService.listarAlunos()).thenAnswer((_) async => alunosMock);
      when(mockAlunoService.listarResponsaveis()).thenAnswer((_) async => []);

      await tester.pumpWidget(ProviderScope(
        overrides: [
          alunoServiceProvider.overrideWithValue(mockAlunoService),
        ],
        child: const MaterialApp(
          home: PesquisaAlunosPage(),
        ),
      ));
      
      await tester.pumpAndSettle(); 

      expect(find.text('Pedro Ramos Sousa Reis'), findsOneWidget);
      expect(find.text('Lucas Silva'), findsOneWidget);

      final barraPesquisa = find.byType(TextField);
      await tester.enterText(barraPesquisa, 'Pedro');
      
      // Dá tempo para a tela atualizar após digitar
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Pedro Ramos Sousa Reis'), findsOneWidget);
      expect(find.text('Lucas Silva'), findsNothing);

      await tester.enterText(barraPesquisa, '');
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Pedro Ramos Sousa Reis'), findsOneWidget);
      expect(find.text('Lucas Silva'), findsOneWidget);
    });

    testWidgets('A lista deve ficar vazia quando aluno nao existir', (WidgetTester tester) async {
      when(mockAlunoService.listarAlunos()).thenAnswer((_) async => alunosMock);
      when(mockAlunoService.listarResponsaveis()).thenAnswer((_) async => []);

      await tester.pumpWidget(ProviderScope(
        overrides: [
          alunoServiceProvider.overrideWithValue(mockAlunoService),
        ],
        child: const MaterialApp(
          home: PesquisaAlunosPage(),
        ),
      ));
      await tester.pumpAndSettle();

      final barraPesquisa = find.byType(TextField);
      await tester.enterText(barraPesquisa, 'NomeQueNaoExiste');
      await tester.testTextInput.receiveAction(TextInputAction.done); // Dispara a pesquisa
      
      // Aguarda 1 segundo a interface responder
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Verifica se a lista filtrou corretamente esvaziando a tela
      expect(find.text('Pedro Ramos Sousa Reis'), findsNothing);
      expect(find.text('Lucas Silva'), findsNothing);
    });
  });
}