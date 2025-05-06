import 'package:go_router/go_router.dart';

import 'navigation_rail.dart';
import '../pages/generator_page.dart';
import '../pages/favorites_page.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    ShellRoute(
        builder: (context, state, child) => MyNavigationRail(child: child),
        routes: [
          GoRoute(
              name: 'home',
              path: MyPath.home,
              builder: (context, state) => const GeneratorPage()),
          GoRoute(
              name: 'favorites',
              path: MyPath.favorites,
              builder: (context, state) => const FavoritesPage()),
        ])
  ],
);

class MyPath {
  static const String home = '/';
  static const String favorites = '/favorites';
}
