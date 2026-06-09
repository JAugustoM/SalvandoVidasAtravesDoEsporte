import 'package:salvando_vidas/main_imports.dart';
import '../home_page_imports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //final isAdmin = context.read<UserService>().isAdmin;

    final sampleStudents = [
      {'nome': 'Fulano', 'turma': '1', 'kimonos': 'Sim', 'ultima': '6 dias'},
      {'nome': 'Beltrano', 'turma': '2', 'kimonos': 'Sim', 'ultima': '4 dias'},
      {'nome': 'Ciclano', 'turma': '3', 'kimonos': 'Não', 'ultima': '0 dias'},
      {'nome': 'Ana', 'turma': '1', 'kimonos': 'Sim', 'ultima': '2 dias'},
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8F8F8), Color(0xFFE4E4E4)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(18, 18, 18,
                MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight + 12,),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    // Metrics cards (2x2) - grid responsivo
                    LayoutBuilder(
                      builder: (context, constraints) {
                        const spacing = 12.0;
                        final itemWidth = (constraints.maxWidth - spacing) / 2;
                        final aspect =
                            itemWidth / 90; // ajuste de altura desejada
                        return GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: spacing,
                          mainAxisSpacing: spacing,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: aspect,
                          children: [
                            MetricCard(
                              title: 'Próximos aniversariantes',
                              value: 'Fulano (3 dias)',
                              color: Colors.white,
                              width: itemWidth,
                            ),
                            MetricCard(
                              title: 'Total de Alunos',
                              value: '35',
                              color: const Color(0xFF2457F0),
                              width: itemWidth,
                            ),
                            MetricCard(
                              title: 'Kimonos Disponíveis',
                              value: '3',
                              color: const Color(0xFF11A6BF),
                              width: itemWidth,
                            ),
                            MetricCard(
                              title: 'Total de Turmas',
                              value: '5',
                              color: Colors.white,
                              width: itemWidth,
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Students list card
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8DDE6),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x22000000),
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Alunos:',
                            style: TextStyle(
                              color: Color(0xFF08216F),
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 220,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: sampleStudents.map((s) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 10,
                                    ),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Color(0xFFE6E6E6),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Text(s['nome'] ?? ''),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            s['turma'] ?? '',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            s['kimonos'] ?? '',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            s['ultima'] ?? '',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Footer quick actions
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => context.go(Routes.cadastros),
                            icon: const Icon(Icons.person_add_alt_1_outlined),
                            label: const Text('Cadastrar Aluno'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF10A9D0),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // espaço inferior gerenciado pelo padding do SingleChildScrollView
                  ],
                ),
              ),
            ),
          ),
        ),
        
      ),
    );
  }
}