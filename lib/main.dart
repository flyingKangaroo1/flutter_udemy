import 'package:flutter/material.dart';

import 'package:flutter_udemy/text_control.dart';

void main() {
  runApp(MyApp());
}

//widget refactoring하고 나서 main파일은 StatelessWidget으로 바꿀 수 있음
class MyApp extends StatelessWidget {
  @override
  //build method, receives context as argument, returns a Widget
  Widget build(BuildContext context) {
    return MaterialApp(
      // : 쓰는거 targeting 생각, named parameter
      home: Scaffold(
        appBar: AppBar(
          title: Text('Assignment 1'),
        ),
        body: TextControl()
      )
    );
  }
}
