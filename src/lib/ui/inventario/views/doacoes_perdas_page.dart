import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class DoacoesPerdasPage extends ConsumerStatefulWidget {
  const DoacoesPerdasPage({super.key});

  @override
  ConsumerState<DoacoesPerdasPage> createState() => _DoacoesPerdasPageState();
}

class _DoacoesPerdasPageState extends ConsumerState<DoacoesPerdasPage> {
  // Variáveis para o formulário de Doação
  String? tamanhoDoacao;
  String? corDoacao;
  final List<String> tamanhos = ['A0', 'A1', 'A2', 'A3', 'A4', 'A5'];
  final List<String> cores = ['Branco', 'Azul', 'Preto', 'Rosa'];

  // Variáveis mockadas para a lista de Perdas
  List<Map<String, dynamic>> kimonosParaPerda = [
    {'desc': 'A3, Branco', 'selected': false},
    {'desc': 'A2, Azul', 'selected': false},
    {'desc': 'A4, Preto', 'selected': false},
    {'desc': 'A1, Rosa', 'selected': false},
    {'desc': 'A0, Branco', 'selected': false},
  ];

  // --- MÉTODOS DOS POP-UPS ---

  void _mostrarConfirmacaoDoacao() {
    if (tamanhoDoacao == null || corDoacao == null) return;

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6), // Fundo escurecido
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Deseja registrar este\nkimono ($tamanhoDoacao, $corDoacao)?',
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade300,
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => Navigator.pop(context), // Cancela e fecha
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.pop(context); // Fecha confirmação
              _mostrarSucessoDoacao(); // Abre sucesso
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _mostrarSucessoDoacao() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'A doação do kimono foi\nregistrada com sucesso!',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: 120,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                setState(() {
                  tamanhoDoacao = null;
                  corDoacao = null;
                });
                Navigator.pop(context);
              },
              child: const Text('Fechar'),
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarConfirmacaoPerda() {
    final selecionados = kimonosParaPerda.where((k) => k['selected'] == true).toList();
    if (selecionados.isEmpty) return;

    // Pega o nome do primeiro selecionado apenas para o protótipo
    String kimonoDesc = selecionados.first['desc'];

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Deseja registrar a perda\ndo kimono ($kimonoDesc)?',
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade300,
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.pop(context);
              _mostrarSucessoPerda();
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _mostrarSucessoPerda() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'A perda do kimono foi\nregistrada com sucesso!',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: 120,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                setState(() {
                  // Limpa a seleção após o sucesso
                  for (var k in kimonosParaPerda) {
                    k['selected'] = false;
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Fechar'),
            ),
          ),
        ],
      ),
    );
  }

  // --- CONSTRUÇÃO DA TELA ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.platinum, AppColors.bgGradientEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botão Voltar
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                child: TextButton.icon(
                  onPressed: () => context.pop(), // Volta para a tela anterior
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 18),
                  label: const Text(
                    'Voltar',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                ),
              ),
              
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      // Cards de Totais
                      Row(
                        children: [
                          Expanded(
                            child: _StatCardInfo(title: 'Doações\nTotais', value: '30'),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _StatCardInfo(title: 'Perdas\nTotais', value: '0'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Card Expansível: Registrar Doação
                      _buildExpandableCard(
                        title: 'Registrar uma doação',
                        subtitle: 'Escolha o tamanho e a cor',
                        isExpandedContent: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  hint: const Text('Tamanho...'),
                                  value: tamanhoDoacao,
                                  items: tamanhos.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (val) => setState(() => tamanhoDoacao = val),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  hint: const Text('Cor...'),
                                  value: corDoacao,
                                  items: cores.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (val) => setState(() => corDoacao = val),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyan,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: (tamanhoDoacao != null && corDoacao != null) 
                                    ? _mostrarConfirmacaoDoacao 
                                    : null, // Fica desabilitado se não preencher tudo
                                child: const Text('Registrar Doação', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Card Expansível: Registrar Perda
                      _buildExpandableCard(
                        title: 'Registrar uma perda',
                        subtitle: 'Escolha o kimono perdido',
                        isExpandedContent: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: kimonosParaPerda.length,
                                itemBuilder: (context, index) {
                                  final kimono = kimonosParaPerda[index];
                                  return CheckboxListTile(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                                    controlAffinity: ListTileControlAffinity.trailing,
                                    title: Row(
                                      children: [
                                        const Icon(Icons.sports_martial_arts, size: 24, color: Colors.black87),
                                        const SizedBox(width: 12),
                                        Text(kimono['desc'], style: const TextStyle(fontSize: 15)),
                                      ],
                                    ),
                                    value: kimono['selected'],
                                    activeColor: Colors.cyan,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        kimono['selected'] = value;
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyan,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: kimonosParaPerda.any((k) => k['selected'] == true)
                                    ? _mostrarConfirmacaoPerda
                                    : null,
                                child: const Text('Registrar Perda', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para construir as áreas expansíveis mantendo o estilo de Card branco com sombra
  Widget _buildExpandableCard({
    required String title,
    required String subtitle,
    required Widget isExpandedContent,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent), // Remove as linhas padrão do ExpansionTile
        child: ExpansionTile(
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
          subtitle: Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.black54)),
          iconColor: Colors.black87,
          collapsedIconColor: Colors.black87,
          childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          children: [
            const SizedBox(height: 8),
            isExpandedContent,
          ],
        ),
      ),
    );
  }
}

// Widget auxiliar para os cards do topo (Totais)
class _StatCardInfo extends StatelessWidget {
  final String title;
  final String value;

  const _StatCardInfo({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}