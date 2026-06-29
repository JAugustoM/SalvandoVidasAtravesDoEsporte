import 'package:salvando_vidas/main_imports.dart';

class BannerLogo extends StatelessWidget {
  const BannerLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: isDark
          ? const EdgeInsets.symmetric(horizontal: 24, vertical: 16)
          : EdgeInsets.zero,
      decoration: isDark
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.12),
                  blurRadius: 16,
                  spreadRadius: 1,
                ),
              ],
            )
          : null,
      child: Image.asset(
        'assets/images/logoMestre.png',
        height: isDark ? 168 : 200,
        fit: BoxFit.contain,
      ),
    );
  }
}