import 'package:dart_mappable/dart_mappable.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';

part 'local_user.mapper.dart';

@MappableEnum()
enum Role { voluntario, admin }

@MappableClass()
class LocalUser with LocalUserMappable {
  final String? id;
  final Role role;
  final String nome;
  final String telefone;
  final String cpf;
  final String email;
  final String? senha;
  final String funcao;
  final Faixa faixa;

  const LocalUser({
    this.id,
    required this.role,
    required this.nome,
    required this.telefone,
    required this.cpf,
    required this.email,
    this.senha,
    required this.funcao,
    required this.faixa,
  });

  static final fromMap = LocalUserMapper.fromMap;
  static final fromJson = LocalUserMapper.fromJson;
}
