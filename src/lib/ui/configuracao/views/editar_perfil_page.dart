import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';

// Importações dos seus componentes customizados
import 'package:salvando_vidas/ui/cadastro_voluntario/widgets/action_button.dart';
import 'package:salvando_vidas/ui/cadastro_voluntario/widgets/input_field.dart';

class EditarPerfilPage extends ConsumerStatefulWidget {
  const EditarPerfilPage({super.key});

  @override
  ConsumerState<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends ConsumerState<EditarPerfilPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Variáveis de estado com todos os campos do voluntário
  String _nome = '';
  String _email = '';
  String _senha = '';
  String _telefone = '';
  String _cpf = '';
  String _funcao = '';

  @override
  void initState() {
    super.initState();
    // Pega os dados atuais do usuário logado para preencher os campos
    final user = ref.read(userServiceProvider).localUser;
    
    if (user != null) {
      _nome = user.nome;
      _email = user.email;
      _telefone = user.telefone; 
      _cpf = user.cpf;
      _funcao = user.funcao ?? '';
    }
  }

  void _salvarAlteracoes() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Passar todas as variáveis (_nome, _email, _telefone, _cpf, _funcao, _senha) 
      // para o método de atualização do Supabase
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil atualizado com sucesso!')),
      );
      context.pop(); // Retorna para a tela de configurações
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BCD4),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => context.pop(),
        ),
        title: const Text('Editar Perfil', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
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
                constraints: const BoxConstraints(maxWidth: 500),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0A000000),
                              blurRadius: 22,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 36,
                              backgroundColor: Color(0xFFE2E6FA),
                              child: Icon(Icons.person, color: Color(0xFF4A55A2), size: 36),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Seus Dados',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Atualize suas informações pessoais abaixo.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            const SizedBox(height: 24),
                            
                            // 1. Nome Completo
                            InputField(
                              initialValue: _nome,
                              update: (value) => _nome = value,
                              error: null,
                              label: 'Nome Completo',
                              hint: 'Digite o nome completo',
                              validatorMessage: 'Informe seu nome',
                            ),
                            const SizedBox(height: 14),
                            
                            // 2. Email
                            InputField(
                              initialValue: _email,
                              update: (value) => _email = value,
                              error: null,
                              label: 'E-mail',
                              hint: 'Digite o email do voluntário',
                              keyboardType: TextInputType.emailAddress,
                              validatorMessage: 'Informe seu e-mail',
                            ),
                            const SizedBox(height: 14),
                            
                            // 3. Senha (Opcional na edição)
                            InputField(
                              initialValue: _senha,
                              update: (value) => _senha = value,
                              error: null,
                              label: 'Nova Senha (opcional)',
                              hint: 'Digite a senha do voluntário (deixe em branco para manter)',
                              validatorMessage: '', 
                            ),
                            const SizedBox(height: 14),

                            // 4. Telefone
                            InputField(
                              initialValue: _telefone,
                              update: (value) => _telefone = value,
                              error: null,
                              label: 'Telefone',
                              hint: 'Digite o telefone de contato',
                              keyboardType: TextInputType.phone,
                              validatorMessage: 'Informe seu telefone',
                            ),
                            const SizedBox(height: 14),

                            // 5. CPF
                            InputField(
                              initialValue: _cpf,
                              update: (value) => _cpf = value,
                              error: null,
                              label: 'CPF',
                              hint: 'Digite o CPF do voluntário',
                              keyboardType: TextInputType.number,
                              validatorMessage: 'Informe seu CPF',
                            ),
                            const SizedBox(height: 14),

                            // 6. Função
                            InputField(
                              initialValue: _funcao,
                              update: (value) => _funcao = value,
                              error: null,
                              label: 'Função',
                              hint: 'Ex.: professor, monitor, apoio',
                              validatorMessage: 'Informe sua função',
                            ),
                            
                            const SizedBox(height: 24),
                            
                            ActionButton(
                              label: 'Salvar Alterações',
                              onPressed: _salvarAlteracoes,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}