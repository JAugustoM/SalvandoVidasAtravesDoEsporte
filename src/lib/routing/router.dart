import 'package:go_router/go_router.dart';
import 'routes.dart';

import '../ui/home/view_models/home_view_models.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(path: Routes.home, builder: (context, state) => MyHomePage()),
  ],
);
