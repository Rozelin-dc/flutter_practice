import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    super.key,
    this.pair,
  });

  final WordPair? pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.displayMedium?.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair?.asLowerCase ?? 'No word selected',
          style: textStyle,
          semanticsLabel: pair != null
              ? '${pair!.first} ${pair!.second}'
              : 'No word selected',
        ),
      ),
    );
  }
}
