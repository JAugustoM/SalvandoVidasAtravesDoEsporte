enum Faixa { branca, cinza, amarela, laranja, verde, azul, roxa, marrom, preta }

class Aluno {
  final BigInt id;
  final String nome;
  final String cpf;
  final DateTime nascimento;
  final String? contato;
  final String? contatoEmergencia;
  final String email;
  final Faixa faixa;
  final int grau;
  final DateTime dataEntrada;
  final String? linkFoto;
  final BigInt? idResponsavel;
  final bool ativo;

  Aluno({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.nascimento,
    required this.email,
    required this.faixa,
    required this.grau,
    required this.dataEntrada,
    required this.ativo,
    this.contato,
    this.contatoEmergencia,
    this.linkFoto,
    this.idResponsavel,
  });
}
