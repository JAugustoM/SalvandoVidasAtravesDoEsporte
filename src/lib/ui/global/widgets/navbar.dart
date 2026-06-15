//Navbar é principal componente utilizado na maioria das páginas logadas
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import '../../../routing/routes.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Pegar apenas o 'path' é mais seguro do que 'toString()' caso a URL tenha parâmetros (ex: /busca-aluno/editar/1)
    final location = GoRouterState.of(context).uri.path;
    final isAdmin = ref.read(userServiceProvider).isAdmin;

    // Usando .startsWith para garantir que sub-rotas mantenham o ícone selecionado
    int currentIndex = 0;
    if (location.startsWith(Routes.buscaAluno)) {
      currentIndex = 1;
    } else if (location.startsWith(Routes.turma)) {
      currentIndex = 2;
    } else if (location.startsWith(Routes.configuracao)) {
      currentIndex = 3;
    } else if (location.startsWith(Routes.admin)) {
      currentIndex = isAdmin ? 4 : 0; // Previne erro de index fora da lista se não for admin
    } else {
      currentIndex = 0; // Fallback para Routes.home
    }

    return NavigationBar(
      selectedIndex: currentIndex,
      backgroundColor: Colors.white,
      indicatorColor: const Color(0x332457F0),

      destinations: [
        /* NavigationDestination(
          icon: Icon(Icons.inventory),
          label: '',
        ), 
        */
        const NavigationDestination(icon: Icon(Icons.home), label: ''),

        // Nova aba de pesquisa adicionada aqui (Índice 1)
        const NavigationDestination(icon: Icon(Icons.search), label: ''),

        const NavigationDestination(icon: Icon(Icons.school), label: ''),

        const NavigationDestination(icon: Icon(Icons.settings), label: ''),

        if (isAdmin) const NavigationDestination(icon: Icon(Icons.people), label: ''),
      ],

      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            context.go(Routes.home);
            break;
          case 1:
            context.go(Routes.buscaAluno); // Redireciona para a tela de pesquisa
            break;
          case 2:
            context.go(Routes.turma);
            break;
          case 3:
            context.go(Routes.configuracao);
            break;
          case 4:
            context.go(Routes.admin);
            break;
        }
      },
    );
  }
}