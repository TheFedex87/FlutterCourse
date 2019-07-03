import 'package:flutter/material.dart';

import './my_text.dart';

class TextControl extends StatefulWidget {
  @override
  _TextControlState createState() => _TextControlState();
}

class _TextControlState extends State<TextControl> {
  String text = 'Initial text';

  void _changeText() {
    setState(() {
      text = 'My New Text'; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          MyText(text),
          RaisedButton(
            child: Text('ChangeText'),
            onPressed: _changeText,
          ),
        ],
      ),
    );
  }
}
