import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 150,
            child: ListView(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 100,
                    height: 100,
                    child: Card(
                      color: Colors.red,
                      child: Text('Test1'),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100,
                    height: 100,
                    child: Card(
                      color: Colors.blue,
                      child: Text('Test2'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 300,
            child: Card(
              child: Text(
                'Test3',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // This is centered since crossAxisAlignment default is centered. In order to move this to the left I have 2 way: 
          // 1: set crossAxisAlignment to left
          // 2: wrap the card with an Align widget and Align it to the left (like Test5 example)
          Card(
            color: Colors.pink,
            child: Text('Test4'),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Card(
              color: Colors.pink,
              child: Text('Test5'),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 200,
              child: Card(
                color: Colors.cyan,
                child: Text('Test6'),
              ),
            ),
          ),
          Container(
            color: Colors.deepOrange,
            width: 200,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Card(
                color: Colors.cyan,
                child: Text('Test7'),
              ),
            ),
          ),
          Container(
            color: Colors.green,
            width: 200,
            child: Card(
              color: Colors.purple,
              child: Text('Test8'),
            ),
          ),
          // In order to extend the full width of the card I can wrap it into a container and set width to double.infinity like next example, or set
          // the crossAxisAlignment to CrossAxisAlignment.stretch
          Container(
            color: Colors.yellow,
            width: double.infinity,
            child: Card(
              color: Colors.pink,
              child: Text('Test10'),
            ),
          ),
          Container(
            color: Colors.indigo,
            width: double.infinity,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Card(
                color: Colors.pink,
                child: Text('Test11'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
