import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fit_image/fit_image.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'webview.dart';

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
    return Text('Loading...');
    }

    List<DocumentSnapshot> item = snapshot.data.documents;
    return Text(item[0]['name']);
    },
    ),
    );
  }
}

class FirestoreRetrieve extends StatefulWidget {
  FirestoreRetrieveState createState() => new FirestoreRetrieveState();
}