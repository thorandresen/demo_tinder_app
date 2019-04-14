import 'dart:async';

import 'package:demo_tinder_app/startscreen.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Politician tinder demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: StartScreenPage(),
    );
  }
}




