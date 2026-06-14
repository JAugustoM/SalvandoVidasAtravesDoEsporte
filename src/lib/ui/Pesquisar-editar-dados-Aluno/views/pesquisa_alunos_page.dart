import 'package:flutter/material.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/aluno/aluno_mock.dart';
import 'package:salvando_vidas/ui/Pesquisar-editar-dados-Aluno/widgets/aluno_expandable_card.dart';

class PesquisaAlunosPage extends StatefulWidget {
  const PesquisaAlunosPage({super.key});

  @override
  State<PesquisaAlunosPage> createState() => _PesquisaAlunosPageState();
}

class _PesquisaAlunosPageState extends State<PesquisaAlunosPage> {
  // 1. Lista original que guarda todos os alunos e nunca é alterada
  final List<Aluno> _todosAlunos = List.from(alunosMock);
  
  // 2. Lista dinâmica que a tela vai desenhar
  List<Aluno> _alunosFiltrados = [];

  @override
  void initState() {
    super.initState();
    // 3. Quando a tela abre, a lista filtrada recebe TODOS os alunos para exibi-los logo de cara
    _alunosFiltrados = List.from(_todosAlunos);
  }

  // 4. Lógica executada a cada letra digitada no TextField
  void _filtrarAlunos(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        // Se apagou a pesquisa, volta a mostrar todo mundo
        _alunosFiltrados = List.from(_todosAlunos);
      } else {
        // Se tem texto, filtra ignorando maiúsculas e minúsculas
        _alunosFiltrados = _todosAlunos.where((aluno) {
          final nomeAluno = aluno.nome.toLowerCase();
          final busca = query.trim().toLowerCase();
          return nomeAluno.contains(busca);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4E4E4),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0, bottom: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                onChanged: _filtrarAlunos, // O filtro é disparado aqui
                decoration: InputDecoration(
                  hintText: 'Insira o nome do aluno',
                  hintStyle: const TextStyle(
                    color: Colors.grey, 
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF00BCD4),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.search, color: Colors.white, size: 22),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          Expanded(
            child: _alunosFiltrados.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum aluno encontrado.',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _alunosFiltrados.length, 
                    itemBuilder: (context, index) {
                      // O ListView constrói os cards usando sempre a lista que sofreu a filtragem
                      return AlunoExpandableCard(aluno: _alunosFiltrados[index]); 
                    },
                  ),
          ),
        ],
      ),
    );
  }
}