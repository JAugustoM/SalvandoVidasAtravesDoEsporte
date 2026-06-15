import 'package:salvando_vidas/data/stores/home/home_store.dart';
import 'package:salvando_vidas/main_imports.dart';
import '../home_page_imports.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeStoreProvider);

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
              padding: EdgeInsets.fromLTRB(
                18,
                18,
                18,
                MediaQuery.of(context).padding.bottom +
                    kBottomNavigationBarHeight +
                    12,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),

                    // Metrics grid: aniversariantes ocupa coluna esquerda inteira (2 linhas)
                    LayoutBuilder(
                      builder: (context, constraints) {
                        const spacing = 12.0;
                        final itemWidth = (constraints.maxWidth - spacing) / 2;
                        final itemHeight = 90.0;
                        final tallHeight = itemHeight * 2 + spacing;

                        return SizedBox(
                          height: tallHeight,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Coluna esquerda: Aniversariantes (altura dupla)
                              SizedBox(
                                width: itemWidth,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x18000000),
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Próximos aniversariantes',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF555555),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Expanded(
                                        child: homeState.when(
                                          data: (state) {
                                            final lista =
                                                state.proximoAniversariante;
                                            if (lista.isEmpty) {
                                              return const Center(
                                                child: Text(
                                                  'Nenhum nos próximos 7 dias',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xFF888888),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              );
                                            }
                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: lista.length,
                                              itemBuilder: (_, i) {
                                                final item = lista[i];
                                                final diasTexto =
                                                    item.dias == 0
                                                        ? 'Hoje! 🎉'
                                                        : item.dias == 1
                                                            ? 'Amanhã'
                                                            : '${item.dias} dias';
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 3),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.cake_outlined,
                                                        size: 14,
                                                        color:
                                                            Color(0xFF11A6BF),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Expanded(
                                                        child: Text(
                                                          item.aluno.nome,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Text(
                                                        diasTexto,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: item.dias == 0
                                                              ? const Color(
                                                                  0xFF2457F0)
                                                              : const Color(
                                                                  0xFF888888),
                                                          fontWeight:
                                                              item.dias == 0
                                                                  ? FontWeight
                                                                      .w700
                                                                  : FontWeight
                                                                      .normal,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          error: (_, __) => const Center(
                                              child: Text('Erro')),
                                          loading: () => const Center(
                                            child: SizedBox(
                                              width: 20,
                                              height: 20,
                                              child:
                                                  CircularProgressIndicator(
                                                      strokeWidth: 2),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(width: spacing),

                              // Coluna direita: Total de Alunos (topo) + Kimonos (baixo)
                              SizedBox(
                                width: itemWidth,
                                child: Column(
                                  children: [
                                    // Total de Alunos
                                    SizedBox(
                                      height: itemHeight,
                                      child: MetricCard(
                                        title: 'Total de Alunos',
                                        value:
                                            '${homeState.value?.alunos.length ?? "..."}',
                                        color: const Color(0xFF2457F0),
                                        width: itemWidth,
                                      ),
                                    ),
                                    const SizedBox(height: spacing),
                                    // Kimonos Disponíveis
                                    SizedBox(
                                      height: itemHeight,
                                      child: MetricCard(
                                        title: 'Kimonos Disponíveis',
                                        value:
                                            '${homeState.value?.kimonosDisponiveis ?? "..."}',
                                        color: const Color(0xFF11A6BF),
                                        width: itemWidth,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                // Header das colunas
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 4,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF0F2F5),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(8),
                                    ),
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color(0xFFDDDDDD),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: const [
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          'Nome',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF555555),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Turma',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF555555),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Kimono',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF555555),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Última\npresença',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF555555),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Lista de alunos
                                SizedBox(
                                  height: 220,
                                  child: homeState.when(
                                    data: (state) {
                                      return RefreshIndicator(
                                        onRefresh: () =>
                                            ref.refresh(homeStoreProvider.future),
                                        child: ListView.builder(
                                    itemCount: state.alunosHome.length,
                                    itemBuilder: (_, index) {
                                      final aluno = state.alunosHome[index];
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
                                              child: Text(aluno.$1),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                '${aluno.$2 ?? "N/A"}',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Não',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(switch (aluno.$3) {
                                                null => "Nunca",
                                                0 => "Hoje",
                                                1 => "Ontem",
                                                _ => "Há ${aluno.$3} dias",
                                              }, textAlign: TextAlign.center),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              error: (error, stack) {
                                switch (error) {
                                  case AppApiException(
                                    :final message,
                                    :final error,
                                  ):
                                    ref
                                        .read(loggerProvider)
                                        .e(message, error: error);
                                  default:
                                    break;
                                }
                                return Center(
                                  child: Text('Erro ao carregar os alunos'),
                                );
                              },
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                              ],
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