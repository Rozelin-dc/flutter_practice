import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router.dart';

class MyNavigationRail extends StatelessWidget {
  const MyNavigationRail({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                backgroundColor: theme.colorScheme.surfaceContainer,
                extended: constraints.maxWidth >= 600,
                destinations: _railItems.map((item) => item.item).toList(),
                selectedIndex: _calcSelectedIndex(context),
                onDestinationSelected: (index) {
                  _onDestinationSelected(context, index);
                },
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

  final _railItems = const [
    _RailItem(
        item: NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text('Home'),
        ),
        path: MyPath.home),
    _RailItem(
        item: NavigationRailDestination(
          icon: Icon(Icons.favorite),
          label: Text('Favorites'),
        ),
        path: MyPath.favorites),
  ];

  int _calcSelectedIndex(BuildContext context) {
    final path = GoRouterState.of(context).fullPath;
    return _railItems.indexWhere((item) => item.path == path);
  }

  void _onDestinationSelected(BuildContext context, int index) {
    final path = _railItems[index].path;
    if (path.isNotEmpty) {
      GoRouter.of(context).push(path);
    }
  }
}

class _RailItem {
  const _RailItem({
    required this.item,
    required this.path,
  });

  final NavigationRailDestination item;
  final String path;
}
