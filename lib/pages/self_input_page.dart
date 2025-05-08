import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/word_card.dart';
import '../stores/word_state.dart';

class SelfInputPage extends HookConsumerWidget {
  const SelfInputPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordStateNotifier = ref.read(wordProvider.notifier);

    final pair = useState<WordPair?>(null);

    final firstController = useTextEditingController();
    final secondController = useTextEditingController();
    void updatePair() {
      if (firstController.text.isEmpty || secondController.text.isEmpty) {
        pair.value = null;
      } else {
        pair.value = WordPair(firstController.text, secondController.text);
      }
    }
    useEffect(() {
      firstController.addListener(updatePair);
      secondController.addListener(updatePair);

      return () {
        firstController.removeListener(updatePair);
        secondController.removeListener(updatePair);
        firstController.dispose();
        secondController.dispose();
      };
    }, []);

    void clearPair() {
      firstController.clear();
      secondController.clear();
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text('Self Input'), automaticallyImplyLeading: false),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              WordCard(pair: pair.value),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 5,
                children: [
                  Expanded(
                    child: TextField(
                      controller: firstController,
                      decoration: const InputDecoration(labelText: 'first'),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: secondController,
                      decoration: const InputDecoration(labelText: 'second'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      wordStateNotifier.toggleFavorite(pair.value);
                      clearPair();
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
