import 'dart:math';

import 'package:flutter/material.dart';

class MyStatefullWidget extends StatefulWidget {
  int id;
  Function removeHandler;

  MyStatefullWidget(this.id, this.removeHandler, Key key) : super(key: key);

  @override
  _MyStatefullWidgetState createState() => _MyStatefullWidgetState();
}

class _MyStatefullWidgetState extends State<MyStatefullWidget> {
  var _bgColor;

  @override
  void initState() {
    var availableColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.yellow,
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _bgColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(widget.id.toString()),
          ),
          RaisedButton(
            child: Text('Remove'),
            onPressed: () => widget.removeHandler(widget.id),
          )
        ],
      ),
    );
  }
}
