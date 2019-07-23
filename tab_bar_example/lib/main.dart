import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TabBar Example'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.add,
                ),
                text: 'Tab 1',
              ),
              Tab(
                icon: Icon(
                  Icons.add_alert,
                ),
                text: 'Tab 2',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Text('Tab 1 Content'),
            ),
            Center(
              child: Text('Tab 2 Content'),
            ),
          ],
        ),
      ),
    );
  }
}
