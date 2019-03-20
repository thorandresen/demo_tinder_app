import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:flutter/material.dart';

class FirestoreRetrieveState extends State<FirestoreRetrieve> {
  String _document = 'LarsLøkke';
  int size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('Venstre').snapshots(),
        builder: (context, snapshot) {
    if (!snapshot.hasData){
      return new CircularProgressIndicator(
        backgroundColor: Colors.red,
      );
    }
    else {
      List<DocumentSnapshot> item = snapshot.data.documents;
      return Text(item[0]['name']);
    }
    },
    ),
    );
  }
}

class FirestoreRetrieve extends StatefulWidget {
  FirestoreRetrieveState createState() => new FirestoreRetrieveState();
}