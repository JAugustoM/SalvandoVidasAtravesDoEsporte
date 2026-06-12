import 'package:salvando_vidas/data/stores/cadastro_aluno/cadastro_aluno.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/cadastro_voluntario/widgets/input_field.dart';

class EtapaDadosBasicos extends ConsumerWidget {
  final GlobalKey<FormState> formKey;

  const EtapaDadosBasicos({super.key, required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cadastro = ref.watch(cadastroAlunoProvider);
    final notifier = ref.read(cadastroAlunoProvider.notifier);

    final dataFormatada = cadastro.nascimento != null
        ? "${cadastro.nascimento!.day.toString().padLeft(2, '0')}/${cadastro.nascimento!.month.toString().padLeft(2, '0')}/${cadastro.nascimento!.year}"
        : '';

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InputField(
              initialValue: cadastro.nome,
              update: notifier.updateNome,
              error: cadastro.nomeError,
              label: 'Nome*',
              hint: 'Digite o nome completo',
              validatorMessage: 'O nome é obrigatório',
            ),
            const SizedBox(height: 14),
            InputField(
              initialValue: cadastro.cpf,
              update: notifier.updateCPF,
              error: cadastro.cpfError,
              label: 'CPF*',
              hint: '000.000.000-00',
              keyboardType: TextInputType.number,
              validatorMessage: 'O CPF é obrigatório',
            ),
            const SizedBox(height: 14),
            InputField(
              initialValue: cadastro.contato,
              update: notifier.updateContato,
              error: cadastro.contatoError,
              label: 'Telefone*',
              hint: '(00) 00000-0000',
              keyboardType: TextInputType.phone,
              validatorMessage: 'O telefone é obrigatório',
            ),
            const SizedBox(height: 14),
            InputField(
              initialValue: cadastro.email,
              update: notifier.updateEmail,
              error: cadastro.emailError,
              label: 'Email*',
              hint: 'email@email.com',
              keyboardType: TextInputType.emailAddress,
              validatorMessage: 'O email é obrigatório',
            ),
            const SizedBox(height: 14),
            buildLabel('Aniversário*'),
            TextFormField(
              key: ValueKey(cadastro.nascimento),
              initialValue: dataFormatada,
              readOnly: true,
              decoration: InputDecoration(
                errorText: cadastro.nascimentoError,
                filled: true,
                fillColor: const Color(0xFFF5F7FB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                suffixIcon: const Icon(
                  Icons.calendar_today,
                  color: Color(0xFF08216F),
                ),
              ),
              validator: (value) => (value == null || value.isEmpty)
                  ? 'A data é obrigatória'
                  : null,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  notifier.updateNascimento(pickedDate);
                }
              },
            ),
            const SizedBox(height: 14),
            buildDropdownField(
              label: 'Tipo sanguíneo*',
              value: cadastro.tipoSanguineo,
              items: TipoSanguineo.values,
              labelBuilder: (tipo) => tipo.nomeVisivel,
              onChanged: (value) {
                if (value != null) {
                  notifier.updateTipoSanguineo(value);
                }
              },
              validatorMessage: 'Selecione o tipo sanguíneo',
            ),
            const SizedBox(height: 14),
            buildDropdownField(
              label: 'Faixa/Grau*',
              value: cadastro.faixa,
              items: Faixa.values,
              labelBuilder: (faixa) => faixa.nomeVisivel,
              onChanged: (value) {
                if (value != null) {
                  notifier.updateFaixa(value);
                }
              },
              validatorMessage: 'Selecione a faixa',
            ),
            const SizedBox(height: 14),
            InputField(
              initialValue: cadastro.idFicha,
              update: notifier.updateIdFicha,
              error: cadastro.idFichaError,
              label: 'ID da ficha',
              hint: 'Digite o id da ficha',
              validatorMessage: 'O ID da ficha deve ser um número',
            ),
          ],
        ),
      ),
    );
  }
}
