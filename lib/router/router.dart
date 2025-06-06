import 'package:go_router/go_router.dart';

import 'navigation_rail.dart';
import '../pages/generator_page.dart';
import '../pages/self_input_page.dart';
import '../pages/favorites_page.dart';
import '../pages/example_page.dart';

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
              name: 'self_input',
              path: MyPath.selfInput,
              builder: (context, state) => const SelfInputPage()),
          GoRoute(
              name: 'favorites',
              path: MyPath.favorites,
              builder: (context, state) => const FavoritesPage()),
          GoRoute(
              name: 'example',
              path: MyPath.example,
              builder: (context, state) => const ExamplePage()),
        ])
  ],
);

class MyPath {
  static const String home = '/';
  static const String selfInput = '/self_input';
  static const String favorites = '/favorites';
  static const String example = '/example';
}
