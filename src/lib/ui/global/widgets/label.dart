import 'package:salvando_vidas/main_imports.dart';

Widget buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFF08216F),
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
    ),
  );
}
