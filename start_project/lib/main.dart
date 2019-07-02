import './product_manager.dart';
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
      body: ProductManager('Food Tester'),
    ));
  }
}
