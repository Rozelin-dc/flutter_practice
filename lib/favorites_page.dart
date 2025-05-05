import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar:
          AppBar(title: Text('Favorites'), automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          shrinkWrap: true,
          children: appState.favorites
              .map((pair) => ListTile(
                    leading: IconButton(
                        onPressed: () {
                          appState.toggleFavorite(pair);
                        },
                        icon: Icon(Icons.delete),
                        color: theme.colorScheme.error),
                    title: Text(pair.asLowerCase),
                    dense: true,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
