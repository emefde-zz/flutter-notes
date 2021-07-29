import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


class SavedWords extends StatelessWidget {

  const SavedWords({
    Key? key, 
    required this.savedWords
  }) : super(key: key);

  final List<WordPair> savedWords;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Words'),
      ),
      body: _buildRows(),
    );
  }

  Widget _buildRows() {
    final _biggerFont = const TextStyle(fontSize: 18.0);
    return ListView.separated(
        padding: EdgeInsets.all(16.0),
        itemCount: savedWords.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              savedWords[index].asPascalCase,
              style: _biggerFont,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
    );
  }
}
