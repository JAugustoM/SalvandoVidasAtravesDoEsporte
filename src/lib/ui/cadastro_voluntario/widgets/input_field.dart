import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salvando_vidas/ui/global/widgets/label.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.update,
    required this.error,
    required this.initialValue,
    required this.label,
    required this.hint,
    required this.validatorMessage,
    this.keyboardType,
    this.fillColor,
    this.inputFormatters,
    super.key,
  });

  final Color? fillColor;
  final void Function(String) update;
  final String? error;
  final String initialValue;
  final String label;
  final String hint;
  final String validatorMessage;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel(label),
        const SizedBox(height: 6),
        TextFormField(
          onChanged: (value) => update(value),
          initialValue: initialValue,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: const TextStyle(
            color: AppColors.deepNavy,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hint,
            errorText: error,
            hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            filled: true,
            fillColor: fillColor ?? AppColors.platinum,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.royalAzure,
                width: 1.2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          validator: (value) {
            final text = (value ?? '').trim();
            if (text.isEmpty) return validatorMessage;
            return null;
          },
        ),
      ],
    );
  }
}