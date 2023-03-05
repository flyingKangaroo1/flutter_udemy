import 'package:flutter/material.dart';

//왜 StatelessWidget
class TextOutput extends StatelessWidget {
  final String mainText;

  TextOutput(this.mainText);

  @override
  Widget build(BuildContext context) {
    return Text(
      mainText, 
      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold), 
      textAlign: TextAlign.center,
    );
  }
}