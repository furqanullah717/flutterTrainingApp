import 'package:english_words/src/word_pair.dart';
import 'package:flutter/material.dart';

class SavedItems extends StatefulWidget {
  Set<WordPair> _saved;
  SavedItems(Set<WordPair> saved) {
    this._saved = saved;
  }

  @override
  _SavedItemsState createState() => _SavedItemsState(_saved);
}

class _SavedItemsState extends State<SavedItems> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  Set<WordPair> _saved;
  _SavedItemsState(Set<WordPair> saved) {
    this._saved = saved;
  }
  @override
  Widget build(BuildContext context) {
    final tiles = _saved.map(
      (WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );
    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Suggestions'),
      ),
      body: ListView(children: divided),
    );
  }
}
