import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Course App'),
        ),
        body: Card(child: Column(children: <Widget>[
          Image.asset('assets/food.jpg'),
          Text('Food paradise')
        ],),),
      ),
    );
  }
}
