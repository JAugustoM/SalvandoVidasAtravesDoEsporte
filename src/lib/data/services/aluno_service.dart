import '../supabase_call.dart';

import 'package:salvando_vidas/domain/aluno.dart';
import 'package:salvando_vidas/domain/responsavel.dart';

class AlunoService {
  final SupabaseClient _supabase;

  AlunoService(this._supabase);

  Future<Result<Aluno?>> cadastrarAluno(Aluno aluno) {
    return safeSupabaseCall(() async {
      final data = await _supabase.from('alunos').insert({
        'nome': aluno.nome,
        'cpf': aluno.cpf,
        'nascimento': aluno.nascimento.toIso8601String().substring(0, 10),
        'contato': aluno.contato,
        'contato_emergencia': aluno.contatoEmergencia,
        'email': aluno.email,
        'faixa': aluno.faixa.name,
        'grau': aluno.grau,
        'link_foto': aluno.linkFoto,
        'id_responsavel': aluno.idResponsavel,
      }).select();

      return data.isNotEmpty ? aluno : null;
    });
  }

  Future<Result<Responsavel?>> cadastrarResponsavel(Responsavel responsavel) {
    return safeSupabaseCall(() async {
      final data = await _supabase.from('alunos').insert({
        'nome': responsavel.nome,
        'cpf': responsavel.cpf,
        'contato': responsavel.contato,
        'email': responsavel.email,
      }).select();

      return data.isNotEmpty ? responsavel : null;
    });
  }

  Future<Result<List<Aluno>>> listarAlunos() {
    return safeSupabaseCall(() async {
      final res = await _supabase.from('alunos').select();

      final alunos = List<Aluno>.empty(growable: true);

      for (final data in res) {
        final aluno = Aluno(
          id: data['id'],
          nome: data['nome'],
          cpf: data['cpf'],
          nascimento: DateTime.parse(data['nascimento']),
          email: data['email'],
          faixa: Faixa.values.byName(data['faixa']),
          grau: data['grau'],
          dataEntrada: DateTime.parse(data['data_entrada']),
          ativo: data['ativo'],
          contato: data['contato'],
          contatoEmergencia: data['contato_emergencia'],
          linkFoto: data['link_foto'],
          idResponsavel: data['id_responsavel'],
        );

        alunos.add(aluno);
      }

      return alunos;
    });
  }

  Future<Result<List<Responsavel>>> listarResponsaveis() {
    return safeSupabaseCall(() async {
      final res = await _supabase.from('responsaveis').select();

      final responsaveis = List<Responsavel>.empty(growable: true);

      for (final data in res) {
        final responsavel = Responsavel(
          id: data['id'],
          nome: data['nome'],
          cpf: data['cpf'],
          contato: data['contato'],
          email: data['email'],
        );

        responsaveis.add(responsavel);
      }

      return responsaveis;
    });
  }
}
