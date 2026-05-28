import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';
import 'package:salvando_vidas/data/services/user_service.dart';
import 'package:salvando_vidas/data/stores/login/login_form.dart';
import 'package:salvando_vidas/routing/routes.dart';
import 'package:salvando_vidas/ui/login/theme/login_colors.dart';
import 'package:salvando_vidas/ui/login/theme/login_text_styles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BotaoEntrar extends StatelessWidget {
  final LoginFormStore store;
  const BotaoEntrar(this.store, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () async {
          if (store.canLogin) {
            try {
              final loggedin = await context.read<UserService>().login(
                store.email,
                store.password,
              );
              if (context.mounted && loggedin) {
                context.go(Routes.home);
              }
            } on AuthApiException catch (e) {
              if (context.mounted) {
                context.read<Logger>().e("Erro ao autenticar", error: e);
              }
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: LoginColors.primaryBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: LoginTextStyles.buttonText,
        ),
        child: const Text('Entrar'),
      ),
    );
  }
}
