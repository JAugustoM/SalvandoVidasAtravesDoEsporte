import 'package:go_router/go_router.dart';
import 'routes.dart';

import '../data/stores/session/user_session.dart';
import '../ui/auth/login_page.dart';
import '../ui/home/admin_page.dart';
import '../ui/home/cadastros_page.dart';
import '../ui/home/home_page.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: Routes.login,
  refreshListenable: userSession,
  redirect: (context, state) {
    final isAdminRoute = state.matchedLocation == Routes.admin;

    if (isAdminRoute && !userSession.isAdmin) {
      return Routes.home;
    }

    return null;
  },
  routes: [
    GoRoute(path: Routes.login, builder: (context, state) => const LoginPage()),
    GoRoute(path: Routes.home, builder: (context, state) => const HomePage()),
    GoRoute(path: Routes.admin, builder: (context, state) => const AdminPage()),
    GoRoute(
      path: Routes.cadastros,
      builder: (context, state) => const CadastrosPage(),
    ),
  ],
);
