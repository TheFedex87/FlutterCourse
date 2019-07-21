import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: <Widget>[
            Container(
              width: 100,
              child: Card(
                color: Colors.red,
                child: Text('Test1'),
              ),
            ),
            Container(
              width: 100,
              child: Card(
                color: Colors.blue,
                child: Text('Test2'),
              ),
            ),
          ],
        ));
  }
}
