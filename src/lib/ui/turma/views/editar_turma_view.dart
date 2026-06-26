import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/data/services/turma_service/turma_service.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/stores/turmas/turmas_store.dart';
import 'package:salvando_vidas/data/stores/presenca/presenca_store.dart';
import 'package:salvando_vidas/data/stores/pesquisa_aluno/pesquisa_aluno_store.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class EditarTurmaView extends ConsumerStatefulWidget {
  final Turma turma;

  const EditarTurmaView({super.key, required this.turma});

  @override
  ConsumerState<EditarTurmaView> createState() => _EditarTurmaViewState();
}

class _EditarTurmaViewState extends ConsumerState<EditarTurmaView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late FaixaEtaria _faixaEtaria;
  late DateTime _horarioInicio;
  late DateTime _horarioFim;
  
  // Dias da semana simplificados para o dropdown conforme a imagem
  String _diasSelecionados = '';
  final List<String> _opcoesDias = [
    'Segundas e Quartas',
    'Terças e Quintas',
    'Sextas',
    'Sábados',
  ];

  Set<int> _alunosSelecionados = {};
  List<Aluno> _todosAlunos = [];

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.turma.nome);
    _faixaEtaria = widget.turma.faixaEtaria;
    _horarioInicio = widget.turma.horarioInicio;
    _horarioFim = widget.turma.horarioFim;
    
    // Inicializar dias selecionados com base no objeto turma
    if (widget.turma.eSegunda && widget.turma.eQuarta) {
      _diasSelecionados = 'Segundas e Quartas';
    } else if (widget.turma.eTerca && widget.turma.eQuinta) {
      _diasSelecionados = 'Terças e Quintas';
    } else if (widget.turma.eSexta) {
      _diasSelecionados = 'Sextas';
    } else if (widget.turma.eSabado) {
      _diasSelecionados = 'Sábados';
    } else {
      _diasSelecionados = _opcoesDias.first;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _salvarAlteracoes() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Deseja salvar as\nalterações?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.deepNavy,
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: AppColors.error),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.deepNavy,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              await _processarSalvamento();
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Future<void> _processarSalvamento() async {
    final turmaService = ref.read(turmaServiceProvider);
    final alunoService = ref.read(alunoServiceProvider);
    
    // Formatar horários conforme o padrão do banco (HH:mm)
    String formatTime(DateTime dt) {
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }

    final diff = <String, dynamic>{
      'nome': _nomeController.text,
      'faixa_etaria': _faixaEtaria.name,
      'horario_inicio': formatTime(_horarioInicio),
      'horario_fim': formatTime(_horarioFim),
      'e_segunda': _diasSelecionados == 'Segundas e Quartas',
      'e_quarta': _diasSelecionados == 'Segundas e Quartas',
      'e_terca': _diasSelecionados == 'Terças e Quintas',
      'e_quinta': _diasSelecionados == 'Terças e Quintas',
      'e_sexta': _diasSelecionados == 'Sextas',
      'e_sabado': _diasSelecionados == 'Sábados',
    };

    try {
      await turmaService.atualizaTurma(widget.turma.id, diff);
      
      // Atualizar alunos (matricular/desmatricular)
      // Esta é uma lógica simplificada para o frontend
      for (final aluno in _todosAlunos) {
        final selecionado = _alunosSelecionados.contains(aluno.id);
        final estavaNaTurma = aluno.idTurma == widget.turma.id;
        
        if (selecionado && !estavaNaTurma) {
          await alunoService.atualizaAluno(aluno.id!, {'id_turma': widget.turma.id});
        } else if (!selecionado && estavaNaTurma) {
          await alunoService.atualizaAluno(aluno.id!, {'id_turma': null});
        }
      }

      // Refresh stores
      ref.invalidate(turmasStoreProvider);
      ref.invalidate(presencaStoreProvider(widget.turma.id));
      await ref.refresh(pesquisaAlunoProvider.future);

      if (!mounted) return;
      
      _mostrarSucesso();
    } catch (e) {
      String mensagem = 'Ocorreu um erro inesperado.';
      if (e is AppApiException) {
        mensagem = e.message;
      } else {
        mensagem = e.toString();
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar: $mensagem'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _mostrarSucesso() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: AppColors.success, size: 64),
            SizedBox(height: 16),
            Text(
              'As alterações foram salvas com sucesso.',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cyanPrimary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              child: const Text('Fechar'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final alunosAsync = ref.watch(pesquisaAlunoProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.platinum,
        elevation: 0,
        leadingWidth: 110,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.deepNavy, size: 22),
          label: const Text(
            'Voltar',
            style: TextStyle(color: AppColors.deepNavy, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          style: TextButton.styleFrom(padding: const EdgeInsets.only(left: 8), alignment: Alignment.centerLeft),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Editar Turma',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.deepNavy),
              ),
              const SizedBox(height: 24),
              _buildLabel('Nome da Turma:'),
              _buildTextField(_nomeController),
              const SizedBox(height: 16),
              _buildLabel('Dia(s) da semana:'),
              _buildDropdown<String>(
                value: _diasSelecionados,
                items: _opcoesDias,
                onChanged: (val) => setState(() => _diasSelecionados = val!),
              ),
              const SizedBox(height: 16),
              _buildLabel('Horário Início:'),
              _buildTimePicker(true),
              const SizedBox(height: 16),
              _buildLabel('Horário Fim:'),
              _buildTimePicker(false),
              const SizedBox(height: 16),
              _buildLabel('Categoria:'),
              _buildDropdown<FaixaEtaria>(
                value: _faixaEtaria,
                items: FaixaEtaria.values,
                itemLabel: (f) => f == FaixaEtaria.infantil ? 'Infantil' : 'Adulto',
                onChanged: (val) => setState(() => _faixaEtaria = val!),
              ),
              const SizedBox(height: 24),
              const Text(
                'Alunos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.deepNavy),
              ),
              const SizedBox(height: 16),
              alunosAsync.when(
                data: (data) {
                  _todosAlunos = data.alunos;
                  // Inicializar seleção se for a primeira vez
                  if (_alunosSelecionados.isEmpty && data.alunos.any((a) => a.idTurma == widget.turma.id)) {
                    _alunosSelecionados = data.alunos
                        .where((a) => a.idTurma == widget.turma.id)
                        .map((a) => a.id!)
                        .toSet();
                  }
                  
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.alunos.length,
                    itemBuilder: (context, index) {
                      final aluno = data.alunos[index];
                      final isSelected = _alunosSelecionados.contains(aluno.id);
                      
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(backgroundColor: Colors.grey[300]),
                        title: Text(aluno.nome, style: const TextStyle(fontWeight: FontWeight.w600)),
                        trailing: Checkbox(
                          value: isSelected,
                          activeColor: AppColors.success,
                          onChanged: (val) {
                            setState(() {
                              if (val!) {
                                _alunosSelecionados.add(aluno.id!);
                              } else {
                                _alunosSelecionados.remove(aluno.id!);
                              }
                            });
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => const Text('Erro ao carregar alunos'),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cyanPrimary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _salvarAlteracoes,
                  child: const Text('Salvar Alterações', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.platinum,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Colors.grey)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildDropdown<T>({required T value, required List<T> items, String Function(T)? itemLabel, required ValueChanged<T?> onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.platinum,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          items: items.map((item) => DropdownMenuItem<T>(
            value: item,
            child: Text(itemLabel != null ? itemLabel(item) : item.toString()),
          )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildTimePicker(bool isInicio) {
    final time = isInicio ? _horarioInicio : _horarioFim;
    return InkWell(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(time),
        );
        if (picked != null) {
          setState(() {
            final now = DateTime.now();
            final newDate = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
            if (isInicio) _horarioInicio = newDate; else _horarioFim = newDate;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.platinum,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${time.hour} horas'),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}