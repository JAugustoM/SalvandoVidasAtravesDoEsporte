import 'package:flutter/material.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

enum TurmaMenuOption { editar, excluir }

class TurmaOptionsMenuWidget extends StatelessWidget {
  final int turmaId;
  final VoidCallback? onEditar;
  final VoidCallback? onExcluir;

  const TurmaOptionsMenuWidget({
    super.key,
    required this.turmaId,
    this.onEditar,
    this.onExcluir,
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
          case TurmaMenuOption.excluir:
            onExcluir?.call();
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
          value: TurmaMenuOption.excluir,
          child: Row(
            children: [
              const Icon(Icons.delete_outline, color: AppColors.error, size: 18),
              const SizedBox(width: 8),
              const Text('Excluir', style: TextStyle(color: AppColors.error)),
            ],
          ),
        ),
      ],
    );
  }
}
