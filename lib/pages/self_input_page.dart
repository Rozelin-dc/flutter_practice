import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/components/word_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../stores/word_state.dart';

class SelfInputPage extends ConsumerStatefulWidget {
  const SelfInputPage({super.key});

  @override
  ConsumerState<SelfInputPage> createState() => _SelfInputPageState();
}

class _SelfInputPageState extends ConsumerState<SelfInputPage> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  WordPair? pair;

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  void _updatePair() {
    if (_firstController.text.isEmpty || _secondController.text.isEmpty) {
      return;
    }

    setState(() {
      pair = WordPair(_firstController.text, _secondController.text);
    });
  }

  void _clearPair() {
    setState(() {
      pair = null;
      _firstController.clear();
      _secondController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final wordStateNotifier = ref.read(wordProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Self Input'), automaticallyImplyLeading: false),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              WordCard(pair: pair),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 5,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _firstController,
                      decoration: const InputDecoration(labelText: 'first'),
                      onChanged: (value) => _updatePair(),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _secondController,
                      decoration: const InputDecoration(labelText: 'second'),
                      onChanged: (value) => _updatePair(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      wordStateNotifier.toggleFavorite(WordPair(_firstController.text, _secondController.text));
                      _clearPair();
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
