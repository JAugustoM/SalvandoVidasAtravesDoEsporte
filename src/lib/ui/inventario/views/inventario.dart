import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class Inventario extends ConsumerWidget {
  const Inventario({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.platinum, AppColors.bgGradientEnd],
          ),
        ),
      ),
    );
  }
}