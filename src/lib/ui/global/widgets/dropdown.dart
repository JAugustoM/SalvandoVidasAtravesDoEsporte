import 'package:salvando_vidas/main_imports.dart';

Widget buildDropdownField<T>({
  required String label,
  required T? value,
  required List<T> items,
  required String Function(T) labelBuilder,
  required ValueChanged<T?> onChanged,
  String? validatorMessage,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildLabel(label),
      DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(
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
        ),
        hint: Text(label.replaceAll('*', '')),
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(labelBuilder(item)),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validatorMessage != null
            ? (v) => v == null ? validatorMessage : null
            : null,
      ),
    ],
  );
}
