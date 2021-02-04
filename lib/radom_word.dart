import 'package:first_codelab/saved_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWord extends StatefulWidget {
  @override
  _RandomWordState createState() => _RandomWordState();
}

class _RandomWordState extends State<RandomWord> {
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  final _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    void _pushSaved() {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          // NEW lines from here...
          builder: (BuildContext context) {
            return SavedItems(_saved);
          }, // ...to here.
        ),
      );
    }

    return Scaffold(
      // Add from here...
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),

      body: _buildSuggestions(),
    );

  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }
          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    var status = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        status ? Icons.favorite : Icons.favorite_border,
        color: status ? Colors.red : null,
      ),
      onTap: () => {
        setState(() {
          if (status) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        })
      },
    );
  }
}
