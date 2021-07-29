import 'package:flutter/material.dart';
import 'package:myapp/RandomWords.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
      theme: ThemeData(
        primaryColor: Color(0xFF1961CB)
      ),
    );
  }

}