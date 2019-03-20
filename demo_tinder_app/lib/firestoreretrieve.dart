import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'itemholder.dart';
import 'dart:async';

import 'package:flutter/material.dart';

class FirestoreRetrieveState extends State<FirestoreRetrieve> {

  var ih = new ItemHolder();

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
      ih.setName(item[0]['name']);
      return Text(ih.getName);
    }
    },
    ),
    );
  }
}

class FirestoreRetrieve extends StatefulWidget {
  FirestoreRetrieveState createState() => new FirestoreRetrieveState();
}