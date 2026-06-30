import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salvando_vidas/data/stores/emprestimo/historico_emprestimos_store.dart';
import 'package:salvando_vidas/data/supabase_call.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class HistoricoEmprestimosPage extends ConsumerStatefulWidget {
  const HistoricoEmprestimosPage({super.key});

  @override
  ConsumerState<HistoricoEmprestimosPage> createState() => _HistoricoEmprestimosPageState();
}

class _HistoricoEmprestimosPageState extends ConsumerState<HistoricoEmprestimosPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(historicoEmprestimosStoreProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
    final appBarBg = isDark ? AppColors.darkTopbar : AppColors.platinum;
    final gradientColors = isDark ? AppColors.bgGradientDark : AppColors.bgGradientLight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBg,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 110,
        leading: TextButton.icon(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back, color: textColor, size: 22),
          label: Text(
            'Voltar',
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
          ),
        ),
        title: Text(
          'Histórico de Empréstimos',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.cyanPrimary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.cyanPrimary,
          indicatorWeight: 3,
          tabs: const [
            Tab(icon: Icon(Icons.people), text: 'Por Aluno'),
            Tab(icon: Icon(Icons.history), text: 'Geral'),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
        child: SafeArea(
          child: state.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.cyanPrimary),
            ),
            error: (err, stack) => Center(
              child: Text(
                'Erro ao carregar histórico',
                style: const TextStyle(color: AppColors.error),
              ),
            ),
            data: (data) => Column(
              children: [
                _buildHeroCard(data.itens, isDark),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildAbaAlunos(data.itens, isDark),
                      _buildAbaGeral(data, isDark),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard(List<HistoricoItem> itens, bool isDark) {
    final ativos = itens.where((i) => i.emprestimo.dataDevolucao == null).length;
    final devolvidos = itens.where((i) => i.emprestimo.dataDevolucao != null).length;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [AppColors.darkInputFill, AppColors.darkSurface]
              : [AppColors.deepNavy, const Color(0xFF1E3A5F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepNavy.withOpacity(isDark ? 0.4 : 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Visão Geral de Empréstimos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Controle em tempo real dos kimonos',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.dry_cleaning, color: AppColors.cyanPrimary, size: 26),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(color: Colors.white24, height: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatMetric('Ativos', '$ativos', AppColors.warning),
              Container(width: 1, height: 35, color: Colors.white24),
              _buildStatMetric('Devolvidos', '$devolvidos', AppColors.success),
              Container(width: 1, height: 35, color: Colors.white24),
              _buildStatMetric('Total Registrado', '${itens.length}', Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildAbaAlunos(List<HistoricoItem> itens, bool isDark) {
    final Map<int, List<HistoricoItem>> porAluno = {};
    for (final item in itens) {
      porAluno.putIfAbsent(item.emprestimo.alunoId, () => []).add(item);
    }

    if (porAluno.isEmpty) {
      return Center(
        child: Text(
          'Nenhum registro encontrado',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    final entries = porAluno.entries.toList()
      ..sort((a, b) {
        final nomeA = a.value.first.aluno?.nome ?? '';
        final nomeB = b.value.first.aluno?.nome ?? '';
        return nomeA.compareTo(nomeB);
      });

    return RefreshIndicator(
      color: AppColors.cyanPrimary,
      onRefresh: () => ref.refresh(historicoEmprestimosStoreProvider.future),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];
          final listaAluno = entry.value;
          final aluno = listaAluno.first.aluno;
          final nome = aluno?.nome ?? 'Aluno #${entry.key}';
          final qtdAtivos = listaAluno.where((i) => i.emprestimo.dataDevolucao == null).length;
          final cardBg = isDark ? AppColors.darkSurface : Colors.white;
          final textColor = isDark ? Colors.white : AppColors.deepNavy;

          return Card(
            color: cardBg,
            margin: const EdgeInsets.only(bottom: 10),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              leading: CircleAvatar(
                backgroundColor: AppColors.royalAzure.withOpacity(0.15),
                child: const Icon(Icons.person, color: AppColors.royalAzure),
              ),
              title: Text(nome, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
              subtitle: Text(
                '${listaAluno.length} registro(s) • $qtdAtivos ativo(s)',
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              trailing: const Icon(Icons.chevron_right, color: AppColors.cyanPrimary),
              onTap: () => _mostrarDialogHistoricoAluno(context, nome, listaAluno, isDark),
            ),
          );
        },
      ),
    );
  }

  void _mostrarDialogHistoricoAluno(BuildContext context, String nome, List<HistoricoItem> itens, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Histórico: $nome',
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.deepNavy,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: itens.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, i) {
              final item = itens[i];
              final isDevolvido = item.emprestimo.dataDevolucao != null;
              final data = item.emprestimo.data;
              final dataFormatada = '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
              
              String devFormatada = 'Em aberto';
              if (isDevolvido) {
                final dev = item.emprestimo.dataDevolucao!;
                devFormatada = '${dev.day.toString().padLeft(2, '0')}/${dev.month.toString().padLeft(2, '0')}/${dev.year}';
              }

              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  isDevolvido ? Icons.check_circle_outline : Icons.pending_actions,
                  color: isDevolvido ? AppColors.success : AppColors.warning,
                ),
                title: Text(
                  'Kimono ${item.emprestimo.tamanho.nomeVisivel} - ${item.emprestimo.cor.nomeVisivel}',
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColors.deepNavy,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  'Empréstimo: $dataFormatada\nDevolução: $devFormatada',
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Fechar',
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.deepNavy,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbaGeral(HistoricoEmprestimosState data, bool isDark) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: _FiltroChips(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _HistoricoLista(data: data),
          ),
        ),
      ],
    );
  }
}

class _FiltroChips extends ConsumerWidget {
  const _FiltroChips();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(historicoEmprestimosStoreProvider);
    final store = ref.read(historicoEmprestimosStoreProvider.notifier);
    final filtroAtual = state.value?.filtroTipo ?? 'todos';

    final opcoes = [
      ('todos', 'Todos'),
      ('emprestimo', 'Empréstimos'),
      ('devolucao', 'Devoluções'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: opcoes.map((op) {
          final (valor, label) = op;
          final selecionado = filtroAtual == valor;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(label),
              selected: selecionado,
              onSelected: (_) => store.updateFiltroTipo(valor),
              selectedColor: AppColors.royalAzure,
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: selecionado ? Colors.white : AppColors.textSecondary,
                fontWeight: selecionado ? FontWeight.w600 : FontWeight.normal,
              ),
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.darkSurface
                  : Colors.white,
              side: BorderSide(
                color: selecionado ? AppColors.royalAzure : AppColors.borderSubtle,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _HistoricoLista extends ConsumerWidget {
  final HistoricoEmprestimosState data;
  const _HistoricoLista({required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final listBg = isDark ? AppColors.darkSurface : Colors.white;

    if (data.itensFiltrados.isEmpty) {
      return Center(
        child: Text(
          'Nenhum registro encontrado',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: listBg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppColors.cardShadow(isDark),
      ),
      child: RefreshIndicator(
        color: AppColors.cyanPrimary,
        onRefresh: () => ref.refresh(historicoEmprestimosStoreProvider.future),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: data.itensFiltrados.length,
          separatorBuilder: (_, __) => Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: isDark ? AppColors.darkDivider : AppColors.divider,
          ),
          itemBuilder: (context, index) {
            final item = data.itensFiltrados[index];
            return _HistoricoTile(item: item);
          },
        ),
      ),
    );
  }
}

class _HistoricoTile extends StatelessWidget {
  final HistoricoItem item;

  const _HistoricoTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.deepNavy;
    final isDevolucao = item.emprestimo.dataDevolucao != null;

    final tipoColor = isDevolucao ? AppColors.success : AppColors.royalAzure;
    final tipoLabel = isDevolucao ? 'Devolução' : 'Empréstimo';
    final tipoIcon = isDevolucao ? Icons.assignment_return_outlined : Icons.assignment_outlined;

    final data = isDevolucao ? item.emprestimo.dataDevolucao! : item.emprestimo.data;
    final dataFormatada =
        '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';

    final nomeAluno = item.aluno?.nome ?? 'Aluno #${item.emprestimo.alunoId}';
    final nomeVoluntario = item.voluntario?.nome ?? '—';
    final kimono = '${item.emprestimo.tamanho.nomeVisivel}, ${item.emprestimo.cor.nomeVisivel}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: tipoColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(tipoIcon, color: tipoColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: tipoColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tipoLabel,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: tipoColor,
                        ),
                      ),
                    ),
                    Text(
                      dataFormatada,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  nomeAluno,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Kimono: $kimono',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 13,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      nomeVoluntario,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}