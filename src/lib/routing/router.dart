import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:salvando_vidas/data/services/user_service.dart';
import 'package:salvando_vidas/ui/home/admin_page.dart';
import 'package:salvando_vidas/ui/home/cadastros_page.dart';
import 'package:salvando_vidas/ui/home/home_page.dart';
import 'package:salvando_vidas/ui/login/views/login_page.dart';
import 'routes.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(path: Routes.home, builder: (context, state) => HomePage()),
    GoRoute(path: Routes.login, builder: (context, state) => LoginPage()),
    GoRoute(path: Routes.admin, builder: (context, state) => AdminPage()),
    GoRoute(
      path: Routes.cadastros,
      builder: (context, state) => CadastrosPage(),
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) async {
    final userService = context.read<UserService>();

    if (!await userService.isLoggedIn()) {
      // Tire o comentário da linha abaixo apenas para testes
      // userService.logout();
      return Routes.login;
    } else {
      return null;
    }
  },
);
