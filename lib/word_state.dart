import 'package:english_words/english_words.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordState {
  final WordPair current;
  final Set<WordPair> favorites;
  WordState(this.current, [Set<WordPair>? favorites])
      : favorites = favorites ?? <WordPair>{};
}

class WordNotifier extends Notifier<WordState> {
  @override
  WordState build() {
    return WordState(WordPair.random());
  }

  void getNext() {
    state = WordState(WordPair.random(), state.favorites);
  }

  void toggleFavorite([WordPair? pair]) {
    var target = pair ?? state.current;
    Set<WordPair> favorites = state.favorites;
    if (state.favorites.contains(target)) {
      state.favorites.remove(target);
    } else {
      state.favorites.add(target);
    }
    state = WordState(state.current, favorites);
  }
}

final wordProvider = NotifierProvider<WordNotifier, WordState>(
  () => WordNotifier(),
);
