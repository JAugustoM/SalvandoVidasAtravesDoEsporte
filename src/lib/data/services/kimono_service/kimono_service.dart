import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';

import '../../supabase_call.dart';
import '../global/global_service.dart';

part 'kimono_service.g.dart';

@Riverpod(keepAlive: true)
KimonoService alunoService(Ref ref) {
  return KimonoService(ref.watch(supabaseClientProvider));
}

class KimonoService {
  final SupabaseClient _supabase;

  KimonoService(this._supabase);

  Future<Doacao> cadastrarDoacao(Doacao doacao) {
    return runSupabaseCall(() async {
      final data = await _supabase
          .from('doacoes')
          .insert(doacao.toMap())
          .select();

      return Doacao.fromMap(data.first);
    });
  }

  Future<Perda> cadastrarPerda(Perda perda) {
    return runSupabaseCall(() async {
      final data = await _supabase
          .from('perdas')
          .insert(perda.toMap())
          .select();

      return Perda.fromMap(data.first);
    });
  }

  Future<Emprestimo> cadastrarEmprestimo(Emprestimo emprestimo) {
    return runSupabaseCall(() async {
      final data = await _supabase
          .from('emprestimos')
          .insert(emprestimo.toMap())
          .select();

      return Emprestimo.fromMap(data.first);
    });
  }

  Future<List<Doacao>> listarDoacoes() {
    return runSupabaseCall(() async {
      final res = await _supabase.from('doacoes').select();
      return res.map((data) => Doacao.fromMap(data)).toList();
    });
  }

  Future<List<Perda>> listarPerdas() {
    return runSupabaseCall(() async {
      final res = await _supabase.from('perdas').select();
      return res.map((data) => Perda.fromMap(data)).toList();
    });
  }

  Future<List<Emprestimo>> listarEmprestimos() {
    return runSupabaseCall(() async {
      final res = await _supabase.from('emprestimos').select();
      return res.map((data) => Emprestimo.fromMap(data)).toList();
    });
  }

  Future<List<Estoque>> obterEstoque() {
    return runSupabaseCall(() async {
      final res = await _supabase.from('estoque_kimonos').select();
      return res.map((data) => Estoque.fromMap(data)).toList();
    });
  }
}
