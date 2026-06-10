import 'package:flutter/material.dart';
import '../core/turma_model.dart';
import 'turma_options_menu_widget.dart';

class TurmaCardWidget extends StatelessWidget {
  final TurmaModel turma;
  final VoidCallback? onTap;
  final VoidCallback? onEditar;
  final VoidCallback? onExcluir;

  const TurmaCardWidget({
    super.key,
    required this.turma,
    this.onTap,
    this.onEditar,
    this.onExcluir,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          border: Border(
            bottom: BorderSide(color: Color(0xFFD9D9D9), width: 1),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    turma.nome,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Alunos: ${turma.totalAlunos}, Dia e Hora: ${turma.diasHorario}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF666666),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            TurmaOptionsMenuWidget(
              turmaId: turma.id,
              onEditar: onEditar,
              onExcluir: onExcluir,
            ),
          ],
        ),
      ),
    );
  }
}