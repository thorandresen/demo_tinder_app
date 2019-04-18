import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavedPoliticiansPage extends StatefulWidget{
  SavedPoliticiansPageState createState() => new SavedPoliticiansPageState();
}

class SavedPoliticiansPageState extends State<SavedPoliticiansPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Saved politicians'),
      ),
    );
  }
}