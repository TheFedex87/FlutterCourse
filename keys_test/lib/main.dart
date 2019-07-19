import 'dart:math';

import 'package:flutter/material.dart';
import 'package:keys_test/my_statefull_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> list = [
    1,
    2,
    3,
    4,
    5,
  ];

  void _removeItem(int id) {
    print('Deleting element $id');
    setState(() {
      list.removeWhere((element) => element == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keys Test'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              height: 500,
              child: ListView(
                children: list
                    .map(
                      (element) => MyStatefullWidget(
                        element,
                        _removeItem,
                        ValueKey(element),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
