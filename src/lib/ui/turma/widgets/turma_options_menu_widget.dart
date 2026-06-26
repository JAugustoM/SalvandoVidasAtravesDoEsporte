import 'package:flutter/material.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

enum TurmaMenuOption { editar, historico }

class TurmaOptionsMenuWidget extends StatelessWidget {
  final int turmaId;
  final VoidCallback? onEditar;

  const TurmaOptionsMenuWidget({
    super.key,
    required this.turmaId,
    this.onEditar,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TurmaMenuOption>(
      icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onSelected: (TurmaMenuOption option) {
        switch (option) {
          case TurmaMenuOption.editar:
            onEditar?.call();
            break;
          case TurmaMenuOption.historico:
            // Futura implementação
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<TurmaMenuOption>(
          value: TurmaMenuOption.editar,
          child: Row(
            children: [
              const Icon(
                Icons.edit_outlined,
                color: AppColors.cyanPrimary,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text('Editar'),
            ],
          ),
        ),
        PopupMenuItem<TurmaMenuOption>(
          value: TurmaMenuOption.historico,
          child: Row(
            children: [
              const Icon(
                Icons.history,
                color: AppColors.deepNavy,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text('Histórico de Frequência'),
            ],
          ),
        ),
      ],
    );
  }
}