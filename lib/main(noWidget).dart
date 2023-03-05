import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _texts = ['flutter', 'is', 'confusing', 'at', 'first'];
  var textIndex = 0;

  void changeText() {
    setState(() {
      textIndex++;
    });
  }

  void resetText() {
    setState(() {
      textIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Assignment 1'),
            ),
            body: Column(children: [
              Container(
                width: double.infinity,
                child: Text(
                  _texts[textIndex],
                  //왜 center 안됨??
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: textIndex < _texts.length-1 ? changeText : resetText,
                child: Text('Press Button'),
              ),
            ])));
  }
}
