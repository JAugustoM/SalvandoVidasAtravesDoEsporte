import 'package:flutter/material.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class EtapaDadosMedicos extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<int, bool?> respostas;
  final Function(int, bool?) onRespostaChanged;
  final TextEditingController obsController;

  const EtapaDadosMedicos({
    super.key,
    required this.formKey,
    required this.respostas,
    required this.onRespostaChanged,
    required this.obsController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPerguntaMedica(1, 'Pergunta médica 1:'),
                _buildPerguntaMedica(2, 'Pergunta médica 2:'),
                _buildPerguntaMedica(3, 'Pergunta médica 3:'),
                _buildPerguntaMedica(4, 'Pergunta médica 4:'),
                _buildPerguntaMedica(5, 'Pergunta médica N:'),
                const SizedBox(height: 16),
                _buildLabel('Observações:'),
                TextFormField(
                  controller: obsController,
                  maxLines: 4,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Digite as observações aqui...',
                    filled: true,
                    fillColor: AppColors.inputFill, // Padronizado com o InputField
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.deepNavy,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildPerguntaMedica(int id, String pergunta) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(pergunta),
          Row(
            children: [
              _buildRadioOption(id, true, 'Sim'),
              const SizedBox(width: 16),
              _buildRadioOption(id, false, 'Não'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(int id, bool value, String label) {
    return InkWell(
      onTap: () => onRespostaChanged(id, value),
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Radio<bool>(
            value: value,
            groupValue: respostas[id],
            onChanged: (bool? v) => onRespostaChanged(id, v),
            activeColor: AppColors.deepNavy,
          ),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}