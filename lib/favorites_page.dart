import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'word_state.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    var wordState = ref.watch(wordProvider);
    var wordStateNotifier = ref.read(wordProvider.notifier);

    return Scaffold(
      appBar:
          AppBar(title: Text('Favorites'), automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          shrinkWrap: true,
          children: wordState.favorites
              .map((pair) => ListTile(
                    leading: IconButton(
                        onPressed: () {
                          wordStateNotifier.toggleFavorite(pair);
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
