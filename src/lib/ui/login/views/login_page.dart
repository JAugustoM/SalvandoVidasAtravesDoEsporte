import 'package:flutter/material.dart';
import 'package:salvando_vidas/data/stores/login/login_form.dart';
import 'package:salvando_vidas/ui/login/theme/login_decorations.dart';
import 'package:salvando_vidas/ui/login/widgets/banner_logo.dart';
import 'package:salvando_vidas/ui/login/widgets/botao_entrar.dart';
import 'package:salvando_vidas/ui/login/widgets/formulario_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginFormStore store = LoginFormStore();

  @override
  void initState() {
    super.initState();
    store.setupValidations();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: LoginDecorations.pageBackground,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BannerLogo(),
                    const SizedBox(height: 28),
                    FormularioLogin(store),
                    const SizedBox(height: 18),
                    BotaoEntrar(store),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
