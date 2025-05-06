import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../stores/word_state.dart';
import '../components/word_card.dart';

class GeneratorPage extends ConsumerWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var wordState = ref.watch(wordProvider);
    var wordStateNotifier = ref.read(wordProvider.notifier);
    var pair = wordState.current;

    return Scaffold(
      appBar: AppBar(
          title: Text('Word Generator'), automaticallyImplyLeading: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            WordCard(pair: pair),
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 5,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    wordStateNotifier.toggleFavorite();
                  },
                  icon: Icon(wordState.favorites.contains(pair)
                      ? Icons.favorite
                      : Icons.favorite_border),
                  label: Text(wordState.favorites.contains(pair)
                      ? 'Unfavorite'
                      : 'Favorite'),
                ),
                ElevatedButton(
                  onPressed: () {
                    wordStateNotifier.getNext();
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
