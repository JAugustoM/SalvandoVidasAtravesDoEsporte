import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

Widget buildLabel(String text) {
  final bool temAsterisco = text.endsWith('*');
  final String textoSemAsterisco = text.replaceAll('*', '');

  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: RichText(
      text: TextSpan(
        text: textoSemAsterisco,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.black, // Cor do texto principal
        ),
        children: [
          if (temAsterisco)
            const TextSpan(
              text: '*',
              style: TextStyle(color: AppColors.error), // Asterisco vermelho
            ),
        ],
      ),
    ),
  );
}
