class TurmaModel {
  final String id;
  final String nome;
  final int totalAlunos;
  final String diasHorario;

  const TurmaModel({
    required this.id,
    required this.nome,
    required this.totalAlunos,
    required this.diasHorario,
  });
}

// Mock data
final List<TurmaModel> turmasMock = List.generate(
  7,
  (index) => TurmaModel(
    id: '${index + 1}',
    nome: 'Turma ${index + 1}',
    totalAlunos: 15,
    diasHorario: 'Terça e Quinta, 8h-10h',
  ),
);

class AlunoModel {
  final String nome;

  AlunoModel({
    required this.nome,
  });
}