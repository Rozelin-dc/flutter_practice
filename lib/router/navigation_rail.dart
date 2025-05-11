import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'router.dart';

class _RailItem {
  const _RailItem({
    required this.item,
    required this.path,
  });

  final NavigationRailDestination item;
  final String path;
}

class MyNavigationRail extends HookWidget {
  const MyNavigationRail({required this.child, super.key});

  final Widget child;

  final _railItems = const [
    _RailItem(
        item: NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text('Home'),
        ),
        path: MyPath.home),
    _RailItem(
        item: NavigationRailDestination(
          icon: Icon(Icons.upload),
          label: Text('Self Input'),
        ),
        path: MyPath.selfInput),
    _RailItem(
        item: NavigationRailDestination(
          icon: Icon(Icons.favorite),
          label: Text('Favorites'),
        ),
        path: MyPath.favorites),
    _RailItem(
        item: NavigationRailDestination(
          icon: Icon(Icons.auto_stories),
          label: Text('Example'),
        ),
        path: MyPath.example),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final path = GoRouterState.of(context).fullPath;

    final selectedIndex = useMemoized(() => _railItems.indexWhere((item) => item.path == path), [path]);
    final onDestinationSelected = useCallback((int index) {
      final newPath = _railItems[index].path;
      if (newPath.isNotEmpty) {
        GoRouter.of(context).push(newPath);
      }
    }, [context]);

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                backgroundColor: theme.colorScheme.surfaceContainer,
                extended: constraints.maxWidth >= 600,
                destinations: _railItems.map((item) => item.item).toList(),
                selectedIndex: selectedIndex,
                onDestinationSelected: onDestinationSelected,
              ),
            ),
            Expanded(
              child: Container(
                color: theme.colorScheme.primaryContainer,
                child: child,
              ),
            ),
          ],
        ),
      );
    });
  }
}
