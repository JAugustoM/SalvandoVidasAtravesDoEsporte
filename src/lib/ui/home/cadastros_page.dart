import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routing/routes.dart';
import 'components/action_button.dart';
import 'components/expansion_action_card.dart';
import 'components/input_field.dart';

class CadastrosPage extends StatefulWidget {
  const CadastrosPage({super.key});

  @override
  State<CadastrosPage> createState() => _CadastrosPageState();
}

class _CadastrosPageState extends State<CadastrosPage> {
  final _studentFormKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  final _studentBirthDateController = TextEditingController();
  final _studentDocumentController = TextEditingController();
  final _studentResponsibleNameController = TextEditingController();
  final _studentResponsiblePhoneController = TextEditingController();
  final _studentResponsibleEmailController = TextEditingController();

  bool _studentExpanded = false;

  @override
  void dispose() {
    _studentNameController.dispose();
    _studentBirthDateController.dispose();
    _studentDocumentController.dispose();
    _studentResponsibleNameController.dispose();
    _studentResponsiblePhoneController.dispose();
    _studentResponsibleEmailController.dispose();
    super.dispose();
  }

  void _toggleStudentPanel() {
    setState(() {
      _studentExpanded = !_studentExpanded;
    });
  }

  void _submitStudent() {
    if (_studentFormKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aluno e responsável cadastrados.')),
      );
      _studentFormKey.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: OutlinedButton.icon(
                        onPressed: () => context.go(Routes.home),
                        icon: const Icon(Icons.arrow_back_outlined),
                        label: const Text('Voltar às seções'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF08216F),
                          side: const BorderSide(
                            color: Color(0xFF08216F),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 26,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF08216F),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x2A000000),
                            blurRadius: 22,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Cadastros',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF10A9D0),
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Área simples para organizar acessos rápidos e cadastrar alunos.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    _SimpleInfoCard(
                      title: 'Voluntários',
                      subtitle: 'Acesso rápido para novos colaboradores.',
                      accentColor: const Color(0xFF11A6BF),
                    ),
                    const SizedBox(height: 16),
                    _SimpleInfoCard(
                      title: 'Turmas',
                      subtitle: 'Cadastro e organização das turmas.',
                      accentColor: const Color(0xFF2457F0),
                    ),
                    const SizedBox(height: 16),
                    ExpansionActionCard(
                      title: 'Cadastrar alunos',
                      subtitle: 'Aluno, responsáveis e vínculo inicial',
                      icon: Icons.person_add_alt_1_outlined,
                      accentColor: const Color(0xFF0B7FA5),
                      expanded: _studentExpanded,
                      onToggle: _toggleStudentPanel,
                      child: Form(
                        key: _studentFormKey,
                        child: Column(
                          children: [
                            InputField(
                              controller: _studentNameController,
                              label: 'Nome do aluno',
                              hint: 'Digite o nome completo do aluno',
                              validatorMessage: 'Informe o nome do aluno',
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              controller: _studentBirthDateController,
                              label: 'Data de nascimento',
                              hint: 'DD/MM/AAAA',
                              keyboardType: TextInputType.datetime,
                              validatorMessage:
                                  'Informe a data de nascimento do aluno',
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              controller: _studentDocumentController,
                              label: 'Matrícula ou documento',
                              hint: 'Número da matrícula ou documento',
                              validatorMessage:
                                  'Informe a matrícula ou documento',
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              controller: _studentResponsibleNameController,
                              label: 'Responsável legal',
                              hint: 'Nome do responsável legal',
                              validatorMessage: 'Informe o responsável legal',
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              controller: _studentResponsiblePhoneController,
                              label: 'Telefone do responsável',
                              hint: 'Telefone para contato',
                              keyboardType: TextInputType.phone,
                              validatorMessage:
                                  'Informe o telefone do responsável',
                            ),
                            const SizedBox(height: 14),
                            InputField(
                              controller: _studentResponsibleEmailController,
                              label: 'Email do responsável',
                              hint: 'Email de contato',
                              keyboardType: TextInputType.emailAddress,
                              validatorMessage:
                                  'Informe o email do responsável',
                            ),
                            const SizedBox(height: 18),
                            ActionButton(
                              label: 'Salvar aluno',
                              onPressed: _submitStudent,
                            ),
                          ],
                        ),
                      ),
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

class _SimpleInfoCard extends StatelessWidget {
  const _SimpleInfoCard({
    required this.title,
    required this.subtitle,
    required this.accentColor,
  });

  final String title;
  final String subtitle;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFD8DDE6),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 58,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF08216F),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF1E2B61),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}