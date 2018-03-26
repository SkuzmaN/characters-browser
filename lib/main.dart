import 'package:flutter/material.dart';
import 'package:marvel_heroes/screens/master_detail_container.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Marvel characters',
      theme: new ThemeData(
        scaffoldBackgroundColor: Colors.black,
        accentColor: Colors.red,
        primaryColor: Colors.red,
        textTheme: new TextTheme(
            body1: new TextStyle(color: Colors.white),
            display1: new TextStyle(color: Colors.white),
            subhead: new TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        primarySwatch: Colors.blue,
        dividerColor: Colors.white,
      ),
      home: new MasterDetailContainer(),
    );
  }
}
