import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>{};

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite([WordPair? pair]) {
    var target = pair ?? current;
    if (favorites.contains(target)) {
      favorites.remove(target);
    } else {
      favorites.add(target);
    }
    notifyListeners();
  }
}
