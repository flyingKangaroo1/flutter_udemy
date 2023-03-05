import 'package:flutter/material.dart';

import './text_output.dart';

//왜 StatefulWidget?
class TextControl extends StatefulWidget {
  @override
  State<TextControl> createState() => _TextControlState();
}

class _TextControlState extends State<TextControl> {
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
    return Column(children: [
      Container(
        width: double.infinity,
        child: TextOutput(_texts[textIndex]),
      ),
      ElevatedButton(
        onPressed: textIndex < _texts.length - 1 ? changeText : resetText,
        child: Text('Press Button'),
      ),
    ]);
  }
}
